require! {
  \./Wrapper
  livescript
}

# process.stdin.once \data __.throttle do
process.stdin.once \data ->
  livescript.run Wrapper it.toString!
  # console.log Wrapper it.toString!
