command: "date +\"%b %d %Y | %H:%M\""

refreshFrequency: 1000

render: (output) ->
  "<div class='date'>#{output}</div>"

style: """
  font-weight: light
  -webkit-font-smoothing: antialiased
  color: #ffffff
  font: 12px SF Mono
  top: 13px
  width: 100%

  .date
    text-align: center
"""
