require! {
  \./Wrapper
  livescript
}

process.stdin.once \data ->
  livescript.run Wrapper it.toString!
 # console.log Wrapper it.toString!
