wrapper = '''
  global import require \\prelude-ls

  goesHere
'''

module.exports = ->
  wrapper.toString!replace 'goesHere' it
