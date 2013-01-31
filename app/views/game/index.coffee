sprites = require '../sprites'

module.exports =
  setup: (engine) ->
    engine.addObject new sprites.Ship
    engine.addObject new sprites.Viking
