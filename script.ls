global import require \prelude-ls

ls = -> []
mv = -> []
rename = -> mv it, it + \_tmp

ls \/bin
|> filter (.[to 2] is \bin)
|> map rename
