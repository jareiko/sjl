Sprite    = require './sprite'

module.exports = class Ship extends Sprite
  textureUrl: 'textures/Ship/viking_2.png'

  setup: ->
    @mesh.scale.set 5, 5, 1
    @mesh.position.x = -3

  update: (client) ->
    @mesh.rotation.z = Math.sin client.time
