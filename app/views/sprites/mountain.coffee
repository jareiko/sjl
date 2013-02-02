Sprite    = require './sprite'

module.exports = class Mountain extends Sprite
  textureUrl: 'textures/Tiles/Background/mountain.png'

  setup: ->
    @mesh.scale.set 51.2, 12, 1
    @mesh.position.y = 1
