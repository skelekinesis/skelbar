command: "osascript -e 'get volume settings' | cut -f2 -d':' | cut -f1 -d',';"

refreshFrequency: 1000 # ms

render: (output) ->
  "Volume: <span>#{output}</span>"

style: """
  font-weight: light
  -webkit-font-smoothing: antialiased
  font: 12px SF Mono
  top: 13px
  right: 447px
  color: #787878
  span
    color: #ffffff
"""
