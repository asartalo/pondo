closeButton = document.createElement('div')
closeButton.innerHTML = "<a class=\"button\" href=\"#\"><img src=\"#{pondoAssets['close.svg']}\"></a>"
closeButton.classList.add('close-button')

app.modal = (id, onLoad = null, onUnload = null) ->
  app.hashChange id,
    ->
      pu.selectAndEach "##{id}", (wrapper) ->
        wrapper.classList.add('active')
        pu.selectAndEach "##{id} .modal-content", (el) ->
          el.appendChild(closeButton)
          pu.animateCss el, 'zoom-in'

      pu.selectAndEach "##{id} a[href=\"#\"]", (el) ->
        cancel = el
        app.showOverlay ->
          cancel.click() if cancel


    ->
      pu.selectAndEach "##{id} .modal-content", (el) ->
        pu.animateCss el, 'zoom-out', ->
          el.parentElement.classList.remove('active')
          el.removeChild(closeButton)

      app.hideOverlay()
