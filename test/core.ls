require! {
  chai: {assert}:c
  '../build/core': _
}

they = it

describe 'Arrays', ->
  #describe '#map2', ->
  #it 'should preserve the value being iterated over', (done)  ->
  #delay = ->
  describe '#push', ->
    they 'should add an element to an array\'s end', ->
      arr = _.push [ 1 to 3 ], 4
      assert.sameMembers arr, [ 1 to 4 ]
      assert.equal arr.3, 4

  describe '#pull', ->
    they 'should add an element to an array', ->
      arr = _.pull [ 2 to 4 ], 1
      assert.sameMembers arr, [ 1 to 4 ]
      assert.equal arr.0, 1

  describe '#unite', ->
    they 'should join two lists together', ->
      arr1 = [ 0 to 5 ]
      arr2 = [ 6 to 9 ]
      arr = _.unite arr1, arr2
      assert.sameMembers arr, [ 0 to 9 ]

  describe '#includes', ->
    they 'should return true iff an element is in the array, else false', ->
      assert.is-true _.includes [1 to 10] 5
      assert.is-false _.includes [1 to 10] 15

describe 'RegExps', ->

  describe '#test', ->
    they 'should return true when tested against a matching regex', ->
      rx = /abc/
      str = '0123abcdef'
      assert.isTrue _.test rx, str
    they 'should return false when tested against a nonmatching regex', ->
      rx = /tuv/
      str = 'abcdef'
      assert.isFalse _.test rx, str

describe 'Strings', ->

  describe '#encode64', ->
    they 'should properly encode a string to base64', ->
      str = 'super secret message'
      assert.equal 'c3VwZXIgc2VjcmV0IG1lc3NhZ2U=' _.encode64 str

  describe '#decode64', ->
    they 'should properly decode a base64 string', ->
      str = 'c3VwZXIgc2VjcmV0IG1lc3NhZ2U='
      assert.equal 'super secret message', _.decode64 str

  describe '#substr', ->
    they 'should return true when tested against a substring', ->
      sub = 'def'
      str = 'abcdef'
      assert.isTrue _.substr sub, str
    they 'should return false when tested against non-substrings', ->
      sub = 'abcdef'
      str = 'abc'
      assert.isFalse _.substr sub, str

  describe '#supstr', ->
    they 'should return true when tested against a superstring', ->
      sup = 'abcdef'
      str = 'bcd'
      assert.isTrue _.supstr sup, str

  describe '#match-all', ->
    they 'should find all matches of a capturing regexp in a string', ->
      rx = /(ing)/
      str = 'I am having a gratifying time being here.'
      matches = _.match-all rx, str
      assert.sameMembers matches, <[ ing ing ing ]>

  describe '#replace-all', ->
    they 'should replace all matches of a regexp in a string', ->
      str = 'John said he would only go if he could talk to Judy.'
      sub = 'Jimmy'
      rx = /he/
      str2 = _.replace-all rx, sub, str
      test-str = 'John said Jimmy would only go if Jimmy could talk to Judy.'
      assert.strictEqual str2, test-str

#describe 'Functions', ->
