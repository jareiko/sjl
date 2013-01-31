
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

  cache[textureUrl] = new THREE.ShaderMaterial
    uniforms:
      tColor:
        type: 't'
        value: THREE.ImageUtils.loadTexture textureUrl
    vertexShader: vertexShader
    fragmentShader: fragmentShader
