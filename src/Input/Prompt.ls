require! {
  blessed
  \./Keyboard
  \./Cursor
}

class Prompt

  (@screen) -> @Init!

  Init: ->
    @keyboad = new Keyboard @screen
    @cursor = new Cursor @screen, @
    @text = blessed.text do
      top: 0
      left: 0
      content: ''

    @screen.append @text

    @screen.on \keypress (key, obj) ~>
      | key?.length and obj.name?.length is 1 => @text.setContent @text.content + key
      | obj.name is 'backspace'               =>
        let x = @cursor.program.x
          switch
          | x is 1 => @text.setContent @text.content[1 to]*''
          | x > 0  => x--; @text.setContent @text.content[til x]*'' + @text.content[x + 1 to]*''

    @cursor.Init!

module.exports = Prompt
