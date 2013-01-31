Sprite    = require './sprite'

module.exports = class Viking extends Sprite
  textureUrl: 'textures/Vikings/viking_2.png'

  setup: ->
    @mesh.scale.set 5, 5, 1
    @mesh.position.x = 3

  update: (client) ->
    @mesh.rotation.z = Math.sin client.time
