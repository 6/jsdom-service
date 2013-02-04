jsdom = require 'jsdom'
fs = require 'fs'
jquerySrc = fs.readFileSync("./jquery-1.9.0.js").toString()
express = require 'express'

app = express()
app.configure ->
  app.use(express.bodyParser())
  app.use(app.router)

app.get '/', (req, res) ->
  res.setHeader('Content-Type', 'text/plain')
  res.send("jsdom-as-a-service is up and running.")

port = process.env.PORT || 5000
console.log "Listening on localhost:#{port}"
app.listen(port)
