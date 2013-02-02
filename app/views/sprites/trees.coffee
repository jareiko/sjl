Sprite    = require './sprite'

module.exports = class Trees extends Sprite
  textureUrl: 'textures/Tiles/Background/treegroup1.png'

  setup: ->
    @mesh.scale.set 20, 15, 1
    @mesh.position.y = 5
