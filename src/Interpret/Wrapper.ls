wrapper = '''
  require! {
    path
  }

  global import require \\prelude-ls
  global import require \\../lib/Helpers

  ___res___ = do ->
    goesHere

  console.log that if ___res___?
'''

module.exports = ->
  it = "''" if not it?.length
  wrapper.toString!replace 'goesHere' it
