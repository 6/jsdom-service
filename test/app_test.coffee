require './test_helper'

describe "app", =>
  before (done) =>
    @server = app.startApp(3456)
    done()

  it "returns 400 if all required params are missing", (done) =>
    http.request().get("/").expect(400, done)


  describe "if the code param is missing", =>
    it "returns 400", (done) =>
      http.request().get("/?html=<h1>fff</h1>").expect(400, done)

    it "returns an error message", (done) =>
      http.request().get("/?html=<h1>fff</h1>").expect(/missing param/i, done)

  describe "if the html param is missing", =>
    it "returns 400", (done) =>
      http.request().get("/?code=result['a']=1;").expect(400, done)

    it "returns an error message", (done) =>
      http.request().get("/?code=result['a']=1;").expect(/missing param/i, done)

  describe "if the code and html params are present", =>
    it "returns 200 ", (done) =>
      http.request().get("/?html=<h1>fff</h1>&code=result['abc']=$('h1').text();").expect(200, done)

    it "returns a null error", (done) =>
      http.request().get("/?html=<h1>fff</h1>&code=result['abc']=$('h1').text();").expect(/"error":null/i, done)

    it "returns result", (done) =>
      http.request().get("/?html=<h1>fff</h1>&code=result['abc']=$('h1').text();").expect(/"result":{"abc":"fff"}/i, done)
