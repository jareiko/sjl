Sprite    = require './sprite'

Vec2 = THREE.Vector2

module.exports = class Tile extends Sprite

  types =
    sky:
      url: 'textures/Tiles/Sky/sky.png'
      width: 51.2
      height: 48.0
    sea1:
      url: 'textures/Tiles/Sea/seatile1_1.png'
      width: 6.4
      height: 48.0

  constructor: (type) ->
    @type = types[type]
    @textureUrl = @type.url
    super()

  setup: ->
    @mesh.scale.set @type.width, @type.height, 1
    @object.position.z = -1

  loadTexture: (texture) ->
    image = texture.image
    @mesh.scale.set image.width * 0.1, image.height * 0.1, 1
