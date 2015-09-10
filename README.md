# LiveShell
Functionnal Shell developed with LiveScript

## Features

- Livescript evaluation
- Live output (Evaluation as you type)
- Each binary in `$PATH` is wrapped (ls, cat, head, ...)
  - Their output are Arrays so you can chain them
```livescript
      ls! |> filter (.length > 10)
```
  - You can pass them an array to make it easy
```livescript
      grep <[-rn console.log .]>
```
- Preloaded `prelude-ls` and `fs`
- `fs` function are pre-curryfied


## Builtins:

```livescript
# Std
string-contains :: Pattern    -> String     -> Booleen

# File related
cd              :: FolderPath -> void
sizeof          :: Path       -> void
is-file         :: Path       -> Booleen
is-dir          :: Path       -> Booleen
grep-file       :: Pattern    -> FilePath   -> [String]
ls-path         :: Path       -> [Path]
```

## Exemples

```livescript
# Useless. Here pwd! returns an Array so we take first item
ls head pwd!

# Equals
ls pwd!0
```

```livescript
# Get every filenames with length > 10
ls! |> filter (.length > 10)
```

```livescript
# Get file name of files that contain 'require'
grep <[-rn require .]>
  |> map split(\:) >> (.0)
  |> unique
```

```livescript
# Get every lines that have 'error' in /var/log
ls-path \/var/log
  |> filter is-file
  |> map grep-file \error
```

## Goals

```livescript
rename = -> mv it, it + \_tmp

ls \/bin
  |> filter (.[to 2] is \bin)
  |> map rename

-------------------------------

bash  |  bin1  |  bin1_tmp
bin1  |  bin2  |  bin2_tmp
bin2  |  bin3  |  bin3_tmp
bin3  |        |
[...]
```

## TODO
- Multiline
- Path management and integration (modify AST)
- Live sandbox to see intermediate data set
- Live snippet integration and definition
- Syntaxic coloration on fly
- Autocompletion/Suggestion on fly (like fish, the friendly interactive shell)
