require! {
  blessed
  \./Prompt
  \./Interpret
  \./Output
}

class LiveShell

  -> @Init!

  Init: ->
    @screen = blessed.screen do
      smartCSR: true
      cursor:
        artificial: true
        shape: \block
        color: null

    @main = blessed.box do
      parent: @screen
      left: 0
      top: 0
      width: @screen.width
      height: @screen.height

    @prompt = new Prompt @screen, @main
    @interpret = new Interpret @screen, @main
    @output = new Output @screen, @main

    @prompt.on \changed ~>
      @output.Set! if not it.length
      @interpret.Run it, (err, stdout) ~>
        @output.Set err || stdout

    @screen.render!

module.exports = new LiveShell
