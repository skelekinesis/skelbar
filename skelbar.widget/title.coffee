options =
  # Enable or disable the widget.
  widgetEnable : true                   # true | false

  # Choose where the widget should sit on your screen.
  verticalPosition    : "top"        # top | bottom | center
  horizontalPosition    : "left"        # left | right | center

command: "osascript 'skelbar.widget/lib/Get Current Track.applescript'"
refreshFrequency: '1s'
style: """
	-webkit-font-smoothing: antialiased
	left: 330 px
// setup
// --------------------------------------------------
display: none
font: 12px SF Mono
font-size: 12px

// variables
// --------------------------------------------------
widgetWidth 300px
borderRadius 1px
infoHeight 12px
infoWidth @widgetWidth - 82

// styles
// --------------------------------------------------
.container
    width: @widgetWidth
    height: @infoHeight
    text-align: left
    position: relative
    clear: both
    color #fff
    background rgba(#000, 0)
    padding 10px
    border-radius @borderRadius

.album-art
    width: 12px
    height: 12px
    border-radius @borderRadius
    background-image: url(now-playing.widget/lib/default.png)
    background-size: 12px
    float: left
    margin-top: 3px

.track-info
    width: @infoWidth
    height: @infoHeight
    margin-left: 20px
    position: relative
    float: left

.artist-name
    font-weight: light
    font-size: 12px
    margin-top: 3px
    margin-bottom: 5px
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis
    color: #ffffff

.track-title
    font-weight: light
    font-size: 12px
    margin-top: 0px
    margin-left: 0px
    text-transform: uppercase
    overflow: hidden
    white-space: nowrap
    text-overflow: ellipsis


.bar-progress
    background: rgba(#fff, .85)
"""

options : options

render: () -> """
<div class="container">
    <div class="album-art"></div>
    <div class="track-info">
	<div id="info">
        	<div class="artist-name"></div>
		<div class="track-title"></div>
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
      tWidth = 100
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
