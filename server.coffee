jsdom = require 'jsdom'
fs = require 'fs'
jquerySrc = fs.readFileSync("./jquery-1.9.0.js").toString()
express = require 'express'

app = express()
app.configure ->
  app.use(express.bodyParser())
  app.use(app.router)

sendSuccess = (res, result) ->
  json = {error: null, result: result}
  res.jsonp(200, json)

sendError = (res, err) ->
  reason = JSON.stringify(err)
  json = {error: {reason: reason}}
  res.jsonp(400, json)

handleRequest = (params, res) ->
  return  sendError(res, "Missing param `html`") unless params.html?
  return  sendError(res, "Missing param `code`") unless params.code?
  try
    jsdom.env
      html: params.html
      src: jquerySrc
      done: (err, window) =>
        if err?
          sendError(res, err)
        else
          result = {}
          $ = window.$
          # Warning: this eval is not sandboxed and is not safe. Do not run with untrusted code.
          eval(params.code)
          sendSuccess(res, result)
  catch err
    sendError(res, err)

app.get '/', (req, res) ->
  handleRequest(req.query, res)

app.post '/', (req, res) ->
  handleRequest(req.params, res)

exports.startApp = (port) ->
  console.log "Listening on localhost:#{port}"
  app.listen(port)
  app
