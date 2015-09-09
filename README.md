# LiveShell
Functionnal Shell developed with LiveScript

## Features

- Livescript evaluation
- Live output
- Each binary in `$PATH` is wrapped (ls, cat, head, ...)
  - Their output are Arrays so you can chain them
```livescript
ls!
|> filter (.length > 10)
```
  - You can pass them an array to make it easy
```livescript
ls <[-a /home]>
|> map (-> it is \.. => \Parent else it)
```
- Preloaded `prelude-ls` and `fs`
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
