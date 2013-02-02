{ Viking } = require '../sprites'

Vec2 = THREE.Vector2

module.exports = class Horde
  constructor: (@engine, @world, @ship) ->
    numVikings = 10
    @inShip = yes
    @pos = new Vec2

    @drum = null
    engine.audio.loadBuffer 'sounds/drum41-mod.ogg', (@drum) =>

    @vikings = for i in [0...numVikings]
      viking = new Viking
      viking.horde = @
      viking.object.position.x = (i / (numVikings - 1)) * 10 - 5
      @ship.object.add viking.object
      viking

  update: (engine) ->
    if @inShip
      @pos.copy @ship.object.position

    seg = @world.getSegmentAt @pos.x

    if @inShip and seg.type isnt 'sea1' then @disembark()

    viking.update engine for viking in @vikings

    unless @inShip
      @pos.set 0, 0
      @pos.add viking.object.position for viking in @vikings
      @pos.multiplyScalar 1 / @vikings.length

    engine.camera.position.x = @pos.x + 15
    #engine.camera.position.y = @pos.y

    for spawn in @world.spawns
      minDist = Infinity
      for viking in @vikings
        dist = viking.object.position.x - spawn.object.position.x
        minDist = dist if Math.abs(dist) < Math.abs(minDist)
      spawn.vikingDistance minDist
    return

  disembark: ->
    viking.disembark() for viking in @vikings
    @inShip = no

  onDrum: (right) ->
    if @drum
      rate = Math.random() * 0.05 + if right then 0.8 else 0.6
      @engine.audio.playSound @drum, no, 0.7, rate
    jumped = 0
    jumped += viking.onDrum() for viking in @vikings
    if @inShip then @ship.onDrum jumped / @vikings.length

  listenSpawns: (spawns) ->
    for spawn in spawns
      do (spawn) =>
        spawn.on 'strike', =>
          for viking in @vikings
            dist = viking.object.position.x - spawn.object.position.x
            if -10 < dist < 2
              viking.onStruck()
