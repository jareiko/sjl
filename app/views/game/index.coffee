sprites = require '../sprites'

module.exports = class Game
  constructor: (engine) ->
    @ship = new sprites.Ship

    vikings = (new sprites.Viking for i in [0...10])

    @ship.object.add viking.object for viking in vikings

    engine.scene.add @ship.object

  update: (engine) ->
    @ship.update engine
