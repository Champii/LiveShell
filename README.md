# LiveShell

Codename: `lish`


Functionnal Shell developed with LiveScript

## Usage

    > npm install -g lish
    > lish

Or

    > git clone https://github.com/Champii/LiveShell.git && cd LiveShell
    > ./bin/lish

You can use `--live` argument to make it evaluate as you type.

#### /!\ Warning
With the `--live` argument: As the shell input is auto-processed every second, be carefull to what you type in. This can lead to various errors and can make your filesystem messy if you don't handle it carefully.

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

# Git related
git-branch      :: void       -> String
pull            :: String     -> [String]
push            :: String     -> [String]
commit          :: String     -> [String]
```

## TODO
- Multiline
- Live sandbox to see intermediate data set
- Live snippet integration and definition
- Syntaxic coloration on fly
- Autocompletion/Suggestion on fly (like fish, the friendly interactive shell)
