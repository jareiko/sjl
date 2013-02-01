Sprite    = require './sprite'

module.exports = class Ship extends Sprite
  name: 'ship'
  textureUrl: 'textures/Ship/ship_1.png'

  setup: ->
    @mesh.scale.set 15, 15, 1
    @mesh.position.y = 5

    @object.position.x = -2

    @rollSpeed = 0
    @moveSpeed = 0

  update: (engine) ->
    @object.position.x = Math.max 0, @object.position.x + @moveSpeed * engine.deltaTime
    @object.position.y = Math.sin(engine.time * 4.0) * 0.5 - 1

    @object.rotation.z += @rollSpeed * engine.deltaTime

    @rollSpeed += Math.sin(engine.time * 2.5) * 0.01
    @rollSpeed += @moveSpeed * 0.003
    @rollSpeed -= @object.rotation.z * 0.2
    @rollSpeed *= Math.pow(0.2, engine.deltaTime)

    @moveSpeed = (@moveSpeed + 3.0) * Math.pow(0.2, engine.deltaTime) - 3.0

  onDrum: (vikingsJumped) ->
    @moveSpeed += vikingsJumped * vikingsJumped * 10
