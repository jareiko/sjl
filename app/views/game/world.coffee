sprites     = require '../sprites'
Tile        = require '../sprites/tile'

module.exports = class World

  segments = [
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
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
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
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
    y = 0
    z = -40
    for i in [-1...10]
      tile = new Tile 'sky'
      scale = 2.1
      tile.mesh.scale.multiplyScalar scale
      x = i * tile.mesh.scale.x
      tile.object.position.set x, y, z
      @object.add tile.object
    return

  buildForeground: ->
    x = 0
    y = -0.5
    z = 1
    for i in [-1..-6]
      tile = new Tile segments[0].type
      x -= tile.mesh.scale.x
      tile.object.position.set x, y, z
      @object.add tile.object
    x = 0
    for segment in segments
      tile = new Tile segment.type
      tile.object.position.set x, y, z
      @object.add tile.object
      segment.left = x
      x += tile.mesh.scale.x
      segment.right = x
    return

  buildSpawns: ->
    @spawns = []
    for segment in segments
      if segment.spawnType
        spawn = new (segment.spawnType)
        spawn.object.position.x = (segment.left + segment.right) / 2
        @object.add spawn.object
        @spawns.push spawn
    return

  getSegmentAt: (x) ->
    for segment, i in segments
      return segment if segment.right > x
    return null

  update: (engine) ->
    spawn.update engine for spawn in @spawns
