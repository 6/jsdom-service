global.sinon = require 'sinon'
sinonChai = require "sinon-chai"
chai = require 'chai'
chai.use(sinonChai)
global.expect = chai.expect

global.app = require '../app'
