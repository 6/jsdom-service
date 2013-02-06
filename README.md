Not safe for production use :fish:

[![Build Status](https://secure.travis-ci.org/6/jsdom-service.png?branch=master)](https://travis-ci.org/6/jsdom-service)

Usage
-----
Include `html` and `code` in request params. Your code will have access to `$` (jquery) and should populate the `result` hash.

Example
-------
```
GET http://localhost:5000/?html=<h1>wut</h1>&code=result['sup']=$('h1').text()
```
returns the following JSON:
```json
{
  "error": null,
  "result": {
    "sup": "wut"
  }
}
```

TODO
----
- Figure out how to sandbox nodejs eval if possible.
