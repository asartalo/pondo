closeButton = document.createElement('div')
closeButton.innerHTML = "<a class=\"button\" href=\"#\"><img src=\"#{pondoAssets['arrow_downward.svg']}\"></a>"
closeButton.classList.add('close-button')

id = "add-income-section"
app.hashChange id,
  ->
    pu.selectAndEach "##{id}", (el) ->
      el.appendChild(closeButton)
      el.classList.add('active')

  ->
    pu.selectAndEach "##{id}", (el) ->
      el.removeChild(el.getElementsByClassName('close-button')[0])
      el.classList.remove('active')

