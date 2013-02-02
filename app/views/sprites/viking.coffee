Sprite    = require './sprite'

Vec2 = THREE.Vector2

module.exports = class Viking extends Sprite
  textureUrls: [
    'textures/Vikings/viking_1.png'
    'textures/Vikings/viking_2.png'
  ]

  setup: ->
    @mesh.scale.set 2, 2, 1
    @mesh.position.y = 1

    #@object.position.y = 0.5

    @vel = new Vec2
    @inShip = yes

  updateInShip: (engine) ->

  updateOnLand: (engine) ->
    deltaX = (Math.random() - 0.5) * 50
    deltaX += @horde.pos.x - @object.position.x
    @vel.x += deltaX * engine.deltaTime
    @vel.x = (@vel.x + 2) * Math.pow(0.2, engine.deltaTime) - 2

    @object.position.x += @vel.x * engine.deltaTime

    seg = @horde.world.getSegmentAt @object.position.x
    if seg.type isnt 'land1'
      if @object.position.y <= 0 and @vel.y <= 0
        if @object.position.x < seg.right
          scale = Math.random() * 7 + 15
          @vel.x = scale
          @vel.y = scale

  update: (engine) ->
    if @inShip
      @updateInShip engine
    else
      @updateOnLand engine
    @vel.y -= 200 * engine.deltaTime
    @object.position.y = Math.max 0, @object.position.y + @vel.y * engine.deltaTime

    if Math.random() < engine.deltaTime * 2
      @animate()

  onDrum: ->
    didJump = no
    if @object.position.y <= 0.0
      @vel.y = Math.random() * 7 + 15
      didJump = yes

    @vel.x += Math.random() * 10 - 1 unless @inShip
    didJump

  onStruck: ->
    scale = Math.random() * 25 + 50
    @vel.x = -scale
    @vel.y = scale

  disembark: ->
    return unless @inShip
    @inShip = no

    # Reparent and fix up coordinate space.
    @object.parent.parent.add @object
    @object.position.copy @object.matrixWorld.getPosition()
