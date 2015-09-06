require! {
  \./Wrapper
  livescript
}

process.stdin.once \data ->
  livescript.run Wrapper it.toString!
