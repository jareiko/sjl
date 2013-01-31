View      = require './view'
template  = require './templates/home'
game      = require './game'

createCanvas = (el) ->
  renderer = new THREE.WebGLRenderer
    alpha: false
    antialias: false
    premultipliedAlpha: false
    clearColor: 0xaaccff
  renderer.setSize window.innerWidth, window.innerHeight
  el.appendChild renderer.domElement

  camera = new THREE.PerspectiveCamera 70, window.innerWidth / window.innerHeight, 1, 200
  camera.position.z = 10

  window.addEventListener 'resize', ->
    camera.aspect = window.innerWidth / window.innerHeight
    camera.updateProjectionMatrix()
    renderer.setSize window.innerWidth, window.innerHeight

  scene = new THREE.Scene()

  objects = []

  addObject = (obj) ->
    scene.add obj.mesh
    objects.push obj

  engine = { addObject }

  game.setup engine

  lastTime = 0

  animate = (time) ->
    requestAnimationFrame animate

    time *= 0.001
    deltaTime = Math.min 0.1, time - lastTime
    lastTime = time

    client = { time, deltaTime }

    for object in objects
      object.update client

    renderer.render scene, camera

  animate 0

module.exports = class HomeView extends View
  id: 'home-view'

  template: template

  afterRender: ->
    createCanvas @el
