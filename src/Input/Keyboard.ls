require! {
  blessed
}

class Keyboard

  (@screen) ->
    @screen.key <[escape C-c]> -> process.exit 0

module.exports = Keyboard
