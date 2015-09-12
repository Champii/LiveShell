require! {
  fs
  child_process: {spawnSync}
  \prelude-ls
}

global import require \prelude-ls

# Wrap every binary found in $PATH
process.env.PATH
|> split ':'
|> concat-map (p) -> (fs.readdirSync p |> map -> p + \/ + it)
|> filter (fs~statSync) >> (.isFile!)
|> each (p) ->
  bin = last split \/ p
  if bin of prelude-ls
    bin += \_
  module.exports[bin] = (...args) ->
    args = &0 if is-type \Array &0
    data = spawnSync bin, args .stdout.toString!split '\n'
    data.pop!
    data

# Curry every fs functions
fs_ = ^^fs |> Obj.map -> if is-type 'Function' it then curry it else it

# Builtins
exports <<<
  # Std
  string-contains: (pattern, string) --> string.search(pattern) != -1

  # Fs utils
  cd:       -> process.chdir it || '~'      # Standard CD
  sizeof:   fs.statSync >> (.size)          # Size of a file
  is-file:  fs.statSync >> (.isFile!)       # Is it a file ?
  is-dir:   fs.statSync >> (.isDirectory!)  # Is it a dir ?
  grep-file: (pattern, file) ~~> exports.cat file |> filter @string-contains pattern

  # Git related
  git-branch: ~>
    exports.git \branch
      |> filter @string-contains "\\* "
      |> head
      |> drop 2

  pull: ~> exports.git <[pull origin]>.push it || @git-branch!
  push: ~> exports.git <[push origin]>.push it || @git-branch!
  commit: ~> exports.git <[commit -am]>.push it || 'Empty message'

  # ls variant that returs full path
  ls-path:  ->
    path = it || exports.pwd!
    exports.ls path
      |> map -> switch path
        | \/  =>  that + it
        | _   =>  that + \/ + it

  # grep variant that take a file and a pattern

  fs:       fs_
