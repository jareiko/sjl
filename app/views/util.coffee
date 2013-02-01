
util =
  KEYCODE:
    BACKSPACE: 8
    TAB: 9
    ENTER: 13
    SHIFT: 16
    CTRL: 17
    ALT: 18
    ESCAPE: 27
    SPACE: 32
    LEFT: 37
    UP: 38
    RIGHT: 39
    DOWN: 40
    DELETE: 46
    COMMA: 188
    PERIOD: 190

for cc in [48..126]
  util.KEYCODE[String.fromCharCode(cc)] = cc

module.exports = util
