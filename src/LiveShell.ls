require! {
  blessed
  \./Prompt
  \./Interpret
  \./Output
  \underscore : __
  \prelude-ls
  fs
  path
}

global import prelude-ls

class LiveShell

  -> @ParseArgs!

  ParseArgs: ->
    @args = process.argv |> drop 2

    return @Shell! if not @args.length

    switch @args.0
      | \--live   => @live = true
      | _         => return @Exec!

    @Shell!

  Shell: ->
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

    evaluate = ~>
      @output.Set! if not it.length
      @interpret.Run it, (err, stdout) ~>
        @output.Set err || stdout

    if @live
      @prompt.on \changed __.throttle evaluate, 1000

    @prompt.on \run evaluate

    @screen.render!

  Exec: ->
    @interpret = new Interpret()
    @interpret.Exec fs.readFileSync(path.resolve(__dirname, @args.0)).toString!, (err, stdout) ~>
      return console.error err if err?

      # console.log stdout
      process.stdout.write stdout
      process.exit 0

module.exports = new LiveShell
