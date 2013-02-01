Horde       = require './horde'
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
    @horde = new Horde @world, @ship

    engine.scene.add @ship.object

    @world.buildForeground()

    @world.buildSpawns()

    @toggleKeys = no

  update: (engine) ->
    @world.update engine
    @ship.update engine
    @horde.update engine

  onKeyDown: (event) ->
    return unless keyWeCareAbout event
    return if isModifierKey event

    key = if @toggleKeys then KEYCODE.A else KEYCODE.L
    if event.keyCode is key
      @toggleKeys = not @toggleKeys
      @horde.onDrum()

    event.preventDefault()
