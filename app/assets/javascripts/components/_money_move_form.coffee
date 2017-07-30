createCloseButton = ->
  closeButton = document.createElement('div')
  closeButton.innerHTML = "<a class=\"button\" href=\"#\"><img src=\"#{pondoAssets['arrow_downward.svg']}\"></a>"
  closeButton.classList.add('close-button')
  closeButton

app.moneyMoveForm = (id) ->
  app.hashChange id,
    ->
      pu.selectAndEach "a[href=\"##{id}\"]", (link) ->
        link.href = "#"
        link.classList.add('active')
        link.dataset.previous = "##{id}"

      pu.selectAndEach "##{id}", (el) ->
        el.appendChild(createCloseButton())
        el.classList.add('active')

    ->
      pu.selectAndEach "##{id}", (el) ->
        el.removeChild(el.getElementsByClassName('close-button')[0])
        el.classList.remove('active')

      pu.selectAndEach "a[data-previous=\"##{id}\"]", (link) ->
        link.href="##{id}"
        link.classList.remove('active')
        link.dataset.previous = ''


