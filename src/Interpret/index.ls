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
    # child.on \close -> done 'close'

    child.stdout.on \data -> done null, it.toString!
    child.stderr.on \data -> done it.toString!

    child.stdin.write string

module.exports = Interpret
