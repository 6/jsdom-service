require './test_helper'

describe "app", =>
  before (done) =>
    @server = app.startApp(3456)
    done()

  it "returns 400 if all required params are missing", (done) =>
    http.request().get("/").expect(400, done)

  it "returns 400 if code params is missing", (done) =>
    http.request().get("/?html=<h1>fff</h1>").expect(400, done)

  it "returns 400 if html params is missing", (done) =>
    http.request().get("/?code=result['a']=1;").expect(400, done)

  it "returns 200 if code and html params ", (done) =>
    http.request().get("/?html=<h1>fff</h1>&code=result['a']=1;").expect(200, done)
