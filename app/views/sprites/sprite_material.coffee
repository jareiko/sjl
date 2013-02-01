
cache = {}

vertexShader =
  """
  varying vec4 eyePosition;
  varying vec3 worldPosition;
  varying vec2 vUv;

  void main() {
    worldPosition = position;
    eyePosition = modelViewMatrix * vec4(worldPosition, 1.0);
    gl_Position = projectionMatrix * eyePosition;

    vUv = uv;
  }
  """
fragmentShader =
  """
  uniform sampler2D tColor;

  varying vec4 eyePosition;
  varying vec3 worldPosition;
  varying vec2 vUv;

  void main() {
    gl_FragColor = texture2D(tColor, vUv);
  }
  """

module.exports = (textureUrl) ->

  if mat = cache[textureUrl] then return mat

  texture = THREE.ImageUtils.loadTexture textureUrl
  texture.magFilter = THREE.NearestFilter
  texture.minFilter = THREE.NearestMipMapNearestFilter
  cache[textureUrl] = new THREE.ShaderMaterial
    transparent: yes
    depthTest: no
    uniforms:
      tColor:
        type: 't'
        value: texture
    vertexShader: vertexShader
    fragmentShader: fragmentShader
