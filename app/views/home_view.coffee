View      = require './view'
template  = require './templates/home'
Game      = require './game'

createCanvas = (el) ->
  renderer = new THREE.WebGLRenderer
    alpha: no
    antialias: no
    premultipliedAlpha: no
    clearColor: 0xaaccff
  renderer.sortObjects = no
  renderer.devicePixelRatio = 1
  renderer.setSize window.innerWidth, window.innerHeight
  el.appendChild renderer.domElement

  camera = new THREE.PerspectiveCamera 70, window.innerWidth / window.innerHeight, 1, 200
  camera.position.z = 30

  window.addEventListener 'resize', ->
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize window.innerWidth, window.innerHeight

  scene = new THREE.Scene()

  objects = [ 'game placeholder' ]

  engine =
    camera: camera
    scene: scene
    addObject: (obj) ->
      scene.add obj.object if obj.object
      objects.push obj
      if obj.name?
        objectsByName[obj.name] ?= []
        objectsByName[obj.name].push obj
    addObjects: (objs) ->
      engine.addObject obj for obj in objs

  objects[0] = game = new Game engine

  document.addEventListener 'keydown', (event) -> game.onKeyDown event

  lastTime = 0

  animate = (time) ->
    requestAnimationFrame animate

    time *= 0.001
    deltaTime = Math.min 0.1, time - lastTime
    lastTime = time

    engine.time = time
    engine.deltaTime = deltaTime

    for object in objects
      object.update engine

    renderer.render scene, camera

  animate 0

module.exports = class HomeView extends View
  id: 'home-view'

  template: template

  afterRender: ->
    createCanvas @el
