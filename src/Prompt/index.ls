require! {
  blessed
  \./Keyboard
  \./Cursor
  events: {EventEmitter}
}

class Prompt extends EventEmitter

  (@screen, @main) -> @Init!

  Init: ->
    @keyboad = new Keyboard @screen
    @cursor = new Cursor @screen, @
    @text = blessed.text do
      parent: @main
      top: 0
      left: 0
      content: ''

    @screen.on \keypress (key, obj) ~>
      | key?.length and \ch of obj            => @Append obj.ch
      | key?.length and obj.name?.length is 1 => @Append key
      | obj.name is \space                    => @Append ' '
      | obj.name is \backspace                =>
        x = @cursor.program.x
        switch
          | x is 1 =>      @Set @Get![1 to]*''
          | x > 0  => x--; @Set @Get![til x]*'' + @Get![x + 1 to]*''

    @cursor.Init!

  Set:    ->
    @text.setContent it
    @emit \changed @Get!

  Append: ->
    x = @cursor.program.x
    @text.setContent @Get![til x]*'' + it + @Get![x to]*''
    @emit \changed @Get!

  Get: ->
    @text.getContent!

module.exports = Prompt
