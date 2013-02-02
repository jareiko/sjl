Audio     = require './audio'
View      = require './view'
template  = require './templates/home'
Game      = require './game'

createRenderer = ->
  renderer = new THREE.WebGLRenderer
    alpha: no
    antialias: no
    premultipliedAlpha: no
    clearColor: 0xaaccff
  renderer.autoClear = no
  renderer.sortObjects = no
  renderer.devicePixelRatio = 1
  renderer.setSize window.innerWidth, window.innerHeight
  renderer

createCanvas = (el) ->
  renderer = createRenderer()
  el.appendChild renderer.domElement

  camera = new THREE.PerspectiveCamera 70, window.innerWidth / window.innerHeight, 1, 200
  camera.position.z = 20

  window.addEventListener 'resize', ->
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize window.innerWidth, window.innerHeight

  scene = new THREE.Scene()

  audio = new Audio()

  engine = { audio, camera, scene }

  game = new Game engine

  document.addEventListener 'keydown', (event) -> game.onKeyDown event
  document.addEventListener 'touchstart', (event) -> game.onTouchStart event

  lastTime = 0

  animate = (time) ->
    requestAnimationFrame animate

    time *= 0.001
    deltaTime = Math.min 0.1, time - lastTime
    lastTime = time

    engine.time = time
    engine.deltaTime = deltaTime

    game.update engine

    renderer.render scene, camera

  animate 0

module.exports = class HomeView extends View
  id: 'home-view'

  template: template

  afterRender: ->
    createCanvas @el
