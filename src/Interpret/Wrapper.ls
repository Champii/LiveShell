wrapper = '''
  require! {
    path
  }

  global import require \\prelude-ls
  global import require \\lish-std

  ___res___ = do ->
    goesHere

  # console.log that if ___res___?
  process.exit 0
'''

module.exports = ->
  it = "''" if not it?.length
  wrapper.toString!replace 'goesHere' it
