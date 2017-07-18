$document = $(document)

button = null
app.hashChange "header-menu",
  ->
    pu.selectAndEach '#header-menu', (el) ->
      el.classList.add('active')

    pu.selectAndEach 'a[href="#header-menu"]', (el) ->
      button = el
      button.href = "#"

    app.showOverlay ->
      button.click() if button

  ->
    pu.selectAndEach '#header-menu', (el) ->
      el.classList.remove('active')

    if button
      button.href="#header-menu"

    app.hideOverlay()

