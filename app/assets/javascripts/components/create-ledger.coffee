$document = $(document)

app.hashChange "create-ledger",
  ->
    pu.selectAndEach '#create-ledger', (el) ->
      el.classList.add('active')

    pu.selectAndEach '#create-ledger a[href="#"]', (el) ->
      cancel = el
      app.showOverlay ->
        cancel.click() if cancel


  ->
    pu.selectAndEach '#create-ledger', (el) ->
      el.classList.remove('active')

    app.hideOverlay()
