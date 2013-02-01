sprites     = require '../sprites'
{ KEYCODE } = require '../util'
World       = require './world'

keyWeCareAbout = (event) ->
  event.keyCode <= 255

isModifierKey = (event) ->
  event.ctrlKey or event.altKey or event.metaKey

module.exports = class Game
  constructor: (engine) ->

    @world = new World
    engine.scene.add @world.object
    @world.buildBackground()

    @ship = new sprites.Ship

    numVikings = 10

    @vikings = for i in [0...numVikings]
      viking = new sprites.Viking
      viking.object.position.x = (i / (numVikings - 1)) * 10 - 5
      @ship.object.add viking.object
      viking

    engine.scene.add @ship.object

    @world.buildForeground()

    @toggleKeys = no

  update: (engine) ->
    @ship.update engine
    viking.update engine for viking in @vikings

    engine.camera.position.x = @ship.object.position.x + 20

  onDrum: ->
    jumped = 0
    jumped += viking.onDrum() for viking in @vikings
    @ship.onDrum jumped / @vikings.length

  onKeyDown: (event) ->
    return unless keyWeCareAbout event
    return if isModifierKey event

    key = if @toggleKeys then KEYCODE.A else KEYCODE.L
    if event.keyCode is key
      @toggleKeys = not @toggleKeys
      @onDrum()
