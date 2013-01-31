Sprite    = require './sprite'

module.exports = class Viking extends Sprite
  name: 'viking'
  textureUrl: 'textures/Vikings/viking_2.png'

  setup: ->
    @mesh.scale.set 2, 2, 1
    @object.position.y = 0.5

  update: (engine) ->
    @mesh.rotation.z = Math.random()
