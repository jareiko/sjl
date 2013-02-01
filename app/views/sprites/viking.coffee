Sprite    = require './sprite'

Vec2 = THREE.Vector2

module.exports = class Viking extends Sprite
  name: 'viking'
  textureUrl: 'textures/Vikings/viking_2.png'

  setup: ->
    @mesh.scale.set 2, 2, 1
    @mesh.position.y = 0.5

    #@object.position.y = 0.5

    @vel = new Vec2

  updateInBoat: (engine) ->
    @object.position.x = @posWithinBoat

  update: (engine) ->
    @object.position.y = Math.max 0, @object.position.y + @vel.y * engine.deltaTime
    @vel.y -= 200 * engine.deltaTime

  onDrum: ->
    didJump = no
    if @object.position.y <= 0.0
      @vel.y = Math.random() * 7 + 15
      didJump = yes

    @vel.x += Math.random() * 10 - 3
    didJump
