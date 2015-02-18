## Molten Core is an expansion of prelude-ls with functions I've needed in
## more than one place.

require! {
  'prelude-ls': {flip, any, lines, unlines, words, unwords, apply}
}

## Arrays
## ------

## like map, but binds the thing being iterated over
map2 = (f, xs) --> [ f x for let x in xs ]

## adds `el` to the end of `arr`, without changing `arr`
push = (arr, el) --> arr ++ el

## adds `el` to the beginning of `arr`, without changing `arr`
pull = (arr, el) --> [ el ] ++ arr

## ordinal sum of two (finite) arrays
unite = (arr1, arr2) --> arr1 ++ arr2

## RegExps
## -------

test = (rx, str) --> rx.test str

## Strings
## -------

## test for whether `sub` appears in `str`
substr = (sub, str) -->
  rx = new RegExp sub
  test rx, str

## test for whether `str` contains `sub`
supstr = flip substr

## returns an array of each match of a regex `re` in `str`
match-all = (re, str) -->
   flags = 'g'
   if re.ignore-case => flags += 'i'
   if re.multiline => flags += 'm'
   rx = new RegExp re.source, flags

   matches = []
   while hit = rx.exec str
      matches = push matches, hit.1

   matches

## global search for a regular expression `rx` and replace with a string `sub`
replace-all = (rx, sub, str) -->
  ## creates an array of lines, then for each line creates an array of words
  str-matrix = str |> lines |> map2 words
  ## check if any word tests positive for the regular expression
  while any (any (rx.test _)), str-matrix
    ## replace the first occurance of the match with the substitution
    str-matrix = map2 (map2 (.replace rx, sub)), str-matrix
  ## glue the words back into lines, then glue the lines back into a paragraph
  str-matrix |> map2 unwords |> unlines

## Functions
## ---------

## Repeats `f` every `t` milliseconds.
## Takes optional array of arguments `args` for `f`.
repeat-fn = (t, f, args) -->
   fn = ->
      set-timeout fn, t
      apply f, args
   fn!

## Non-curried version of `repeat-fn`.
## If supplied, the optional `args` are not an array.
repeat-fn1 = (t, f, ...args) ->
   fn = ->
      set-timeout fn, t
      f ...args
   fn!

## Verbose version of repeat-fn.
## Must supply a string `n`ame that describes the function.
repeat-fn2 = (t, f, n, args) -->
   fn = ->
      set-timeout fn, t
      console.log "Beginning new loop for #n"
      apply f, args
   fn!

## exports
module.exports =
  map2: map2
  push: push
  pull: pull
  unite: unite
  test: test
  substr: substr
  supstr: supstr
  match-all: match-all
  replace-all: replace-all
  repeat-fn: repeat-fn
  repeat-fn1: repeat-fn1
  repeat-fn2: repeat-fn2
module.exports <<< require 'prelude-ls'
