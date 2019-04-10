command: "pmset -g batt | egrep '([0-9]+\%).*' -o --colour=auto | cut -f1 -d';'"

refreshFrequency: 150000 # ms

render: (output) ->
  "Battery: <span>#{output}</span>"

style: """
  font-weight: light
  -webkit-font-smoothing: antialiased
  font: 12px SF Mono
  top: 13px
  right: 340px
  color: #ffffff
  span
    color: #ffffff
"""
