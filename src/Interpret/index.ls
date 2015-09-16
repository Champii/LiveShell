require! {
  child_process: {fork}
}
global import require \prelude-ls

class Interpret

  (@screen, @main) ->

  Normalize: ->
    it = it
      |> split \\n
      |> map -> '  ' + it
      |> join \\n
    it = drop 2 it

  Exec: (string, _done) !->
    @_Fork @Normalize(string), _done

  Run: (string, _done) !->
    string = "console.log do -> #{@Normalize string}"
    @_Fork string, _done

  _Fork: (string, _done)->
    child = fork __dirname + \/Runner, silent: true

    done = ->
      _done ...
      done = ->

    out = []

    child.on \error -> done \error

    child.stdout.on \data -> out.push it.toString!
    child.on \close -> done null out.join ''
    child.stderr.on \data -> done it.toString!
    # child.stdout.on \data -> done null, it.toString!
    # child.stderr.on \data -> done it.toString!

    child.stdout.on \error -> done \error_stdout
    child.stdin.on \error -> done \error_stdin
    child.stdin.write string

module.exports = Interpret
