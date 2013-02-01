Sprite    = require './sprite'

Vec2 = THREE.Vector2

module.exports = class Giant extends Sprite
  textureUrls: [
    'textures/Monsters/Giant/giant_1.png'
    'textures/Monsters/Giant/giant_2.png'
    'textures/Monsters/Giant/giant_3.png'
  ]

  states =
    IDLE: 0
    ATTACK1: 1  # Club raised, about to strike.
    ATTACK2: 2  # Club brought down.

  setup: ->
    @mesh.scale.set 10, 10, 1
    @mesh.position.y = 4.5

    @state = states.IDLE
    @stateTime = 0

  update: (engine) ->
    @stateTime += engine.deltaTime

    switch @state
      when states.ATTACK1
        if @stateTime > 2 then @setState states.ATTACK2
      when states.ATTACK2
        if @stateTime > 2 then @setState states.IDLE

  setState: (@state) ->
    @setAnimationFrame state
    @stateTime = 0

  vikingDistance: (dist) ->
    if -15 < dist < 0
      if @state is states.IDLE
        @setState states.ATTACK1
