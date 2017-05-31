# $ ->
#   $('body').css backgroundColor: 'orange'
active = false

$(document).on 'click', 'a, [type="submit"]', ->
  $('body').addClass('testing-visiting')
  setTimeout(
    ->
      if active
        $('body').removeClass('testing-visiting')
    300
  )


$(document).on 'turbolinks:before-visit', ->
  active = true
  $('body').addClass('testing-visiting')

$(document).on 'turbolinks:load', ->
  active = false
  $('body').removeClass('testing-visiting')
