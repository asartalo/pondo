$(document).on 'click', 'a[href]', (e) ->
  e.preventDefault()
  link = $(e.currentTarget)
  url = link.attr('href')
  $.ajax(
    url: url
    contentType: false
    complete: (xhr, status) ->
      code = $.trim(xhr.responseText)
      match = code.match(/<body[^>]*>([\s\S]+)<\/body>/)
      bodyCode = $.trim match[1]
      parsed = $.parseHTML(bodyCode)
      $('body').html parsed
      location = window.location
      console.log url
      window.history.pushState null, null, url
  )
