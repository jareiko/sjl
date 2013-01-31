
module.exports = class Sprite
  constructor: (client) ->
    @quad = new THREE.Mesh client.spriteGeom, client.spriteMat
