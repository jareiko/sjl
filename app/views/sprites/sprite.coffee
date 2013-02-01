spriteMaterial = require './sprite_material'

module.exports = class Sprite extends THREE.Mesh

  geom = new THREE.PlaneGeometry 1, 1

  constructor: (client) ->
    @materials = if @textureUrls
      (spriteMaterial url for url in @textureUrls)
    else
      [ spriteMaterial @textureUrl ]
    @matIndex = 0
    @mesh = new THREE.Mesh geom, @materials[@matIndex]
    @object = new THREE.Object3D
    @object.add @mesh
    @setup()

  setup: ->

  animate: ->
    @matIndex = (@matIndex + 1) % @textureUrls.length
    @mesh.material = @materials[@matIndex]
