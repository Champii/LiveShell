require! {
  blessed
  \./Input/Prompt
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

    @prompt = new Prompt @screen

    @screen.render!

module.exports = new LiveShell
