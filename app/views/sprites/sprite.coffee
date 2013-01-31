spriteMaterial = require './sprite_material'

module.exports = class Sprite extends THREE.Mesh

  geom = new THREE.PlaneGeometry 1, 1

  constructor: (client) ->
    @material = spriteMaterial @textureUrl
    @mesh = new THREE.Mesh geom, @material
    @setup()

  setup: ->
