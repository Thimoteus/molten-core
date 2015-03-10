## Molten Core is an expansion of prelude-ls with functions I've needed in
## more than one place.

require! {
  'prelude-ls': {flip, any, lines, unlines, words, unwords, apply, fold1}
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

## checks if `x` is in `xs`
includes = (xs, x) --> x in xs

## RegExps
## -------

test = (rx, str) --> rx.test str

## Strings
## -------

encode64 = (str) ->
  a = new Buffer str
  a.toString 'base64'

decode64 = (str64) ->
  a = new Buffer str64, 'base64'
  a.toString!

## test for whether `sub` appears in `str`
substr = (sub, str) -->
  0 <= str.index-of sub

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

compose = (...fs) ->
  compose-two = (f, g) -> f . g
  fold1 compose-two, fs

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

module.exports <<< require 'prelude-ls'

## exports
module.exports = {
  # arrays
  map2
  push
  pull
  unite
  includes
  # regexps
  test
  # strings
  encode64
  decode64
  substr
  supstr
  match-all
  replace-all
  # functions
  compose
  repeat-fn
  repeat-fn1
  repeat-fn2
}
