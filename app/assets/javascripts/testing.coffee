#= require nitrolinks/load-helper

class PondoTesting
  constructor: (@window) ->
    @errors = []

  listen: ->
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
  @pondoTesting = new PondoTesting(window)
  @pondoTesting.listen()

