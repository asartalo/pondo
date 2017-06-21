$document = $(document)

$document.on 'click', '.menu-button', (e) ->
  e.preventDefault()
  $button = $(e.currentTarget)
  $menu = $($button.attr('href'))
  if $menu.is('.active')
    $menu.removeClass('active')
  else
    $menu.addClass('active')

