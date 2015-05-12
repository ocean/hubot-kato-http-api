chai = require 'chai'
sinon = require 'sinon'
chai.use require 'sinon-chai'

expect = chai.expect

describe 'kato-http-api', ->
  beforeEach ->
    @robot =
      respond: sinon.spy()
      hear: sinon.spy()

    require('../src/kato-http-api')(@robot)

#  it 'registers a respond listener', ->
#    expect(@robot.respond).to.have.been.calledWith(/tucker me/i)
#
#  it 'registers a hear listener', ->
#    expect(@robot.hear).to.have.been.calledWith(/malc(\s+|olm)/i)
