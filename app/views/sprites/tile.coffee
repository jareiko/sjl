Sprite    = require './sprite'

Vec2 = THREE.Vector2

module.exports = class Tile extends Sprite

  types =
    sky:
      urls: [ 'textures/Tiles/Sky/sky.png' ]
      width: 512
      height: 480
    sea1:
      urls: [
        'textures/Tiles/Sea/seatile1_1.png'
        'textures/Tiles/Sea/seatile1_2.png'
      ]
      width: 64
      height: 480
    shore1:
      urls: [
        'textures/Tiles/Shore/shoretile1_1.png'
        'textures/Tiles/Shore/shoretile1_2.png'
      ]
      width: 128
      height: 480
    land1:
      urls: [
        'textures/Tiles/Land/landtile1_1.png'
      ]
      width: 64
      height: 480

  constructor: (type) ->
    @type = types[type]
    @textureUrls = @type.urls
    super()

  setup: ->
    @mesh.scale.set @type.width * 0.1, @type.height * 0.1, 1
    @mesh.position.x = @mesh.scale.x * 0.5
    @object.position.z = -1
