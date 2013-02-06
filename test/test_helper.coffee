global.sinon = require 'sinon'
sinonChai = require "sinon-chai"
chai = require 'chai'
chai.use(sinonChai)
global.expect = chai.expect
global.http = require './http_helpers'

global.app = require '../server'
