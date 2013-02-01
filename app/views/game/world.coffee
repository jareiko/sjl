Tile = require '../sprites/tile'

module.exports = class World

  segments = [
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'shore1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
  ]

  constructor: ->
    @object = new THREE.Object3D

  buildBackground: ->
    for i in [-1...10]
      tile = new Tile 'sky'
      scale = 2.1
      tile.mesh.scale.multiplyScalar scale
      tile.object.position.x = i * tile.mesh.scale.x
      tile.object.position.z = -40
      @object.add tile.object

  buildForeground: ->
    y = -0.5
    progress = 0
    for i in [-1..-6]
      tile = new Tile segments[0].type
      progress -= tile.mesh.scale.x
      tile.object.position.set progress, y, 1
      @object.add tile.object
    progress = 0
    for segment in segments
      tile = new Tile segment.type
      tile.object.position.set progress, y, 1
      @object.add tile.object
      progress += tile.mesh.scale.x
      segment.x = progress

  getSegmentAt: (x) ->
    for segment, i in segments
      return segment if segment.x > x
    return null
