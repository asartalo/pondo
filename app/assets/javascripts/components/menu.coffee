$document = $(document)

app.hashChange "header-menu",
  ->
    pu.selectAndEach '#header-menu', (el) ->
      el.classList.add('active')

    pu.selectAndEach 'a[href="#"]', (el) ->
      button = el
      app.showOverlay ->
        button.click() if button

  ->
    pu.selectAndEach '#header-menu', (el) ->
      el.classList.remove('active')

    app.hideOverlay()

