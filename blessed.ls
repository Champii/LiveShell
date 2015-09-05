require! {
  blessed
}

screen = blessed.screen do
  smartCSR: true
  cursor:
    artificial: true
    shape: \line
    blink: true
    color: null

text = blessed.text do
  top: 0
  left: 0
  content: ''

screen.append text

screen.key <[escape q C-c]> -> process.exit 0

text.focus!

screen.render!

screen.on \keypress ->
  text.content += it
  screen.render!
