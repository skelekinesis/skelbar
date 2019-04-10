options =
  # Enable or disable the widget.
  widgetEnable : true                   # true | false

  # Choose where the widget should sit on your screen.
  verticalPosition    : "top"        # top | bottom | center
  horizontalPosition    : "left"        # left | right | center

command: "osascript 'skelbar.widget/lib2/Get Current Track.applescript'"
refreshFrequency: '1s'
style: """

// setup
// --------------------------------------------------
display: none
font-family system, -apple-system, "Helvetica Neue"
font-size: 10px
margin = 22px

// variables
// --------------------------------------------------
widgetWidth 300px
borderRadius 1px
infoHeight 72px
infoWidth @widgetWidth - 82

// screen positioning calculations
// --------------------------------------------------
if #{options.verticalPosition} == center
    top 50%
    transform translateY(-50%)
else
    #{options.verticalPosition} margin

if #{options.horizontalPosition} == center
    left 50%
    transform translateX(-50%)
else
    #{options.horizontalPosition} margin

// styles
// --------------------------------------------------
.container
    width: 12
    height: 12
    text-align: left
    position: relative
    clear: both
    color #fff
    background rgba(#000, 0)
    padding 10px
    border-radius @borderRadius

.album-art
    width: 12
    height: 12
    border-radius @borderRadius
    background-image: url(now-playing.widget/lib/default.png)
    background-size: cover
    float: left

.track-info
    width: @infoWidth
    height: @infoHeight
    margin-left: 10px
    position: relative
    float: left

.artist-name
    font-weight: bold
    text-transform: uppercase
    margin-top: 3px
    margin-bottom: 5px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.track-title
    font-size: 14px
    text-transform: uppercase
    margin-bottom: 5px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.album-title
    font-weight: bold
    text-transform: uppercase
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis

.bar-container
    width: 300%
    height: @borderRadius
    margin-left: 259px
    border-radius: 400
    background: rgba(#000, 0)

.bar
    width: 300%
    height: @borderRadius
    margin-left: 0px
    border-radius: 400
    transition: width .2s
    margin-top: -3px


.bar-progress
    background: rgba(#fff, .85)
"""

options : options

render: () -> """
<div class="container">
    <div class="album-art"></div>
    <div class="track-info">
        <div class="bar-container">
            <div class="bar bar-progress"></div>
        </div>
        <div class="console">
        </div>
    </div>
</div>
"""

# Update the rendered output.
update: (output, domEl) ->

  div = $(domEl)

  if @options.widgetEnable

    if !output
      div.animate({opacity: 0}, 250, 'swing').hide(1)
    else
      values = output.slice(0,-1).split(" @ ")
      div.find('.artist-name').html(values[0])
      div.find('.track-title').html(values[1])
      div.find('.album-title').html(values[2])
      tDuration = values[3]
      tPosition = values[4]
      tArtwork = values[5]
      songChanged = values[6]
      currArt = "/" + div.find('.album-art').css('background-image').split('/').slice(-3).join().replace(/\,/g, '/').slice(0,-1)
      tWidth = 840
      tCurrent = (tPosition / tDuration) * tWidth
      div.find('.bar-progress').css width: tCurrent
      div.show(1).animate({opacity: 1}, 250, 'swing')

      if currArt isnt tArtwork and tArtwork isnt 'NA'
        artwork = div.find('.album-art')
        artwork.css('background-image', 'url('+tArtwork+')')
      else if tArtwork is 'NA'
        artwork = div.find('.album-art')
        artwork.css('background-image', 'url(now-playing.widget/lib/default.png)')
  else
    div.hide()
