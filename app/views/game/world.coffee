sprites     = require '../sprites'
Tile        = require '../sprites/tile'

module.exports = class World

  segments = [
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1', bg: sprites.Mountain, bgz: -15 }
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
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'sea1' }
    { type: 'shore1' }
    { type: 'land1', bg: sprites.Mountain, bgz: -10 }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Trees, bgz: -5 }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Mountain, bgz: -5 }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Trees }
    { type: 'land1', bg: sprites.Trees, bgz: -5 }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Trees }
    { type: 'land1', bg: sprites.Mountain, bgz: -5 }
    { type: 'land1', bg: sprites.Trees, bgz: -3 }
    { type: 'land1' }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1', spawnType: sprites.Giant }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Trees }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Trees, bgz: -3 }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Trees }
    { type: 'land1', bg: sprites.Mountain, bgz: -5 }
    { type: 'land1', bg: sprites.Trees, bgz: -3 }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1' }
    { type: 'land1', bg: sprites.Valhalla, bgz: -3 }
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

    x = 0
    y = 0
    z = 0
    for segment in segments
      tile = new Tile segment.type
      tile.object.position.set x, y, z
      segment.tile = tile
      segment.left = x
      x += tile.mesh.scale.x
      segment.right = x

  buildBackground: ->
    y = -2
    z = -50
    for i in [-1...10]
      tile = new Tile 'sky'
      scale = 2.1
      tile.mesh.scale.multiplyScalar scale
      x = i * tile.mesh.scale.x
      tile.object.position.set x, y, z
      @object.add tile.object

    for segment in segments
      if segment.bg
        bg = new (segment.bg)
        bg.object.position.x = (segment.left + segment.right) / 2
        bg.object.position.z = segment.bgz or -10
        @object.add bg.object

    return

  buildForeground: ->
    x = 0
    y = 0
    z = 0
    for i in [-1..-6]
      tile = new Tile segments[0].type
      x -= tile.mesh.scale.x
      tile.object.position.set x, y, z
      @object.add tile.object
    x = 0
    for segment in segments
      @object.add segment.tile.object
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
