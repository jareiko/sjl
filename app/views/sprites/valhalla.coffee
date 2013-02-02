Sprite    = require './sprite'

module.exports = class Valhalla extends Sprite
  textureUrl: 'textures/Tiles/Background/vikinghouse.png'

  setup: ->
    @mesh.scale.set 25.6, 13.4, 1
    @mesh.scale.multiplyScalar 0.8
    @mesh.position.y = 5
