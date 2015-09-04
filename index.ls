require! {
  fs
  \prelude-ls
  child_process
}

global import prelude-ls

prompt = '$ '

print = -> each (process.stdout~write), &

read-path = Func.memoize -> fs.readdirSync \/bin

read-from-stdin = -> run that.toString![til -1]*''/' ' if process.stdin.read!

run = ->
  return print prompt if not it? or not it.length or it.0 is ''

  cmd = child_process.spawn it.0, tail it

  cmd.stdout.on \data  -> print it
  cmd.on \close        -> print prompt
  cmd.on \error        -> console.log 'Command not found'

print prompt

process.stdin.on \readable read-from-stdin
