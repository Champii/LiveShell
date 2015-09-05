require! {
  fs
  \prelude-ls
  child_process
  # \./blessed
}

global import prelude-ls

prompt = '$ '

# print :: String -> void
print = -> each ((.toString!) >> process.stdout~write), &

#read-path :: void -> [String]
read-path = Func.memoize -> fs.readdirSync \/bin

# read-from-stdin :: void -> void
read-from-stdin = -> run that.toString![til -1]*''/' ' if process.stdin.read!

# run :: [String] -> void
run = ->
  return print prompt if not it? or not it.length or it.0 is ''

  cmd = child_process.spawn it.0, tail it
    ..stdout.on \data  -> print it
    ..on \close        -> print prompt
    ..on \error        -> console.log 'Command not found'

print prompt

process.stdin.on \readable read-from-stdin
