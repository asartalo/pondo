$.fn.extend animateCss: (animationName, callback) ->
  animationEnd = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
  @addClass('animated ' + animationName).one animationEnd, ->
    callback() if callback
    $(this).removeClass 'animated ' + animationName
    return
  return

