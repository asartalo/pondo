class PondoTesting
  constructor: (@window, @document, @body) ->
    @active = false
    @errors = []

  init: ->
    @listen()

  markAsLoading: (from)->
    @active = true
    @body.addClass('testing-visiting')

  markAsDoneLoading: ->
    @active = false
    @body.removeClass('testing-visiting')

  listen: ->
    @document.on 'nitrolinks:visit', =>
      @markAsLoading('nitrolinks:visit')

    @document.on 'nitrolinks:load nitrolinks:load-blank', (e) =>
      @markAsDoneLoading()

    @window.addEventListener 'error', (e) =>
      @addToErrors(e)

  addToErrors: (e) ->
    if e.error
      @errors.push e.error.message
    else
      @errors.push e
    console.log e

  hasJavascriptErrors: ->
    @error.length > 0

$ =>
  @pondoTesting = new PondoTesting(window, $(document), $('body'))
  @pondoTesting.init()

