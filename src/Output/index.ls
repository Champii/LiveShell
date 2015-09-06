require! {
  blessed
}

class Output

  (@screen, @main) -> @Init!

  Init: ->
    @text = blessed.text do
      parent: @main
      bottom: 0
      content: ''

  Set:    ->
    @text.setContent it || ''
    @screen.render!

module.exports = Output
