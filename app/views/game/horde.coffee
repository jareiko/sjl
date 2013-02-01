{ Viking } = require '../sprites'

Vec2 = THREE.Vector2

module.exports = class Horde
  constructor: (@world, @ship) ->
    numVikings = 10
    @inShip = yes
    @pos = new Vec2

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

    engine.camera.position.x = @pos.x + 20
    #engine.camera.position.y = @pos.y

  disembark: ->
    viking.disembark() for viking in @vikings
    @inShip = no

  onDrum: ->
    jumped = 0
    jumped += viking.onDrum() for viking in @vikings
    if @inShip then @ship.onDrum jumped / @vikings.length
