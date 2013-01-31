View      = require './view'
template  = require './templates/home'

viking    = require './webgl/viking'


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

  client = {}

  client.scene = new THREE.Scene()

  quadGeom = new THREE.PlaneGeometry 1, 1
  quadMat = new THREE.ShaderMaterial
    vertexShader:
      """
      varying vec4 eyePosition;
      varying vec3 worldPosition;

      void main() {
            worldPosition = position;
            eyePosition = modelViewMatrix * vec4(worldPosition, 1.0);
            gl_Position = projectionMatrix * eyePosition;
      }
      """
    fragmentShader:
      """
      varying vec4 eyePosition;
      varying vec3 worldPosition;

      void main() {
        gl_FragColor = vec4(0.1, 0.2, 0.3, 1.0);
      }
      """

  client.quad = new THREE.Mesh quadGeom, quadMat

  client.scene.add client.quad

  lastTime = Date.now()

  do animate = ->
    requestAnimationFrame animate

    time = Date.now()
    deltaTime = Math.min 0.1, time - lastTime
    lastTime = time

    quad.rotation.z += deltaTime

    renderer.render scene, camera


module.exports = class HomeView extends View
  id: 'home-view'

  template: template

  afterRender: ->
    createCanvas @el
