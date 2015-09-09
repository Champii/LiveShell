require! {
  blessed
}

class Cursor

  (@screen, @prompt) ->

  Init: ->
    @program = @screen.program

    @screen.program.showCursor!

    @screen.on \keypress (key, obj) ~>
      | key?.length and \ch of obj                                       => @program.cursorForward!
      | key?.length and obj.name?.length is 1                            => @program.cursorForward!
      | obj.name is \space                                               => @program.cursorForward!
      | obj.name is \right and @program.x < @prompt.text.content.length  => @program.cursorForward!
      | obj.name is \backspace                                           => @program.cursorBackward!
      | obj.name is \left                                                => @program.cursorBackward!
      | obj.name is \enter                                               => @program.cursorDown!
      @screen.render!

module.exports = Cursor
