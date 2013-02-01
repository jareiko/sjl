Tile = require '../sprites/tile'

module.exports = class World
  constructor: ->
    @object = new THREE.Object3D

  buildBackground: ->
    for i in [-1...10]
      tile = new Tile 'sky'
      scale = 2.1
      tile.mesh.scale.multiplyScalar scale
      tile.object.position.x = i * tile.type.width * scale
      tile.object.position.z = -40
      @object.add tile.object

  buildForeground: ->
    for i in [-3...100]
      tile = new Tile 'sea1'
      tile.object.position.x = i * 6.4
      tile.object.position.z = 1
      @object.add tile.object
