require! {
  child_process: {fork}
}

class Interpret

  (@screen, @main) ->

  Run: (string, _done) !->
    child = fork __dirname + \/Runner, silent: true

    done = ->
      _done ...
      done = ->

    child.on \error -> done \error

    child.stdout.on \data -> done null, it.toString!
    child.stderr.on \data -> done it.toString!

    child.stdout.on \error -> done \error_stdout
    child.stdin.on \error -> done \error_stdin
    child.stdin.write string

module.exports = Interpret
