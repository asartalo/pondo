# Pondo Utilities
@pu = ((document, window) ->
  ifElseFn = (test, fn1, fn2) ->
    if test then fn1 else fn2

  ifFn = (test, fn) ->
    fn if test

  merge = (a, b) ->
    Object.assign(a, b)

  async = (fn, interval = 0) ->
    ->
      args = arguments
      setTimeout(
        ->
          fn.apply(fn, args)
        interval
      )

  eventFactory = ifElseFn(
    window.CustomEvent,
    (event, data) ->
      new CustomEvent(event, detail: data, bubbles: true, cancelable: true)
    (event, data) ->
      theEvent = document.createEvent('CustomEvent')
      theEvent.initCustomEvent event, true, true, data
      theEvent
  )

  whenReady = (fn) ->
    document.addEventListener("DOMContentLoaded", fn)

  eventDelegate = (event, selector, handler) ->
    document.addEventListener event, (e) ->
      target = e.target
      while target and target != this
        if target.matches(selector)
          e.current = target
          handler.call target, e
          break
        target = target.parentNode
      return

  triggerEvent = (event, data = {}) ->
    document.dispatchEvent eventFactory(event, data)
    event

  handleLinkClicks = (fn) ->
    eventDelegate 'click', 'a[href]', (e) ->
      link = e.current
      url = new URL(link.href)
      fn(url, e)

  handleFormSubmits = (fn) ->
    eventDelegate 'submit', 'form', (e) ->
      form = e.current
      fn(form, e)

  getContentOfElement = (selector, defaultValue = null) ->
    node = document.querySelector(selector)
    if node then node.content else defaultValue

  isCurrentPageReloaded = ->
    window.performance.navigation.type = 1

  # Stolen from Turbolinks
  uuid = ->
    result = ""
    for i in [1..36]
      if i in [9, 14, 19, 24]
        result += "-"
      else if i is 15
        result += "4"
      else if i is 20
        result += (Math.floor(Math.random() * 4) + 8).toString(16)
      else
        result += Math.floor(Math.random() * 15).toString(16)
    result

  return {
    getContentOfElement: getContentOfElement
    ifElseFn: ifElseFn
    ifFn: ifFn
    merge: merge
    eventFactory: eventFactory
    whenReady: whenReady
    eventDelegate: eventDelegate
    triggerEvent: triggerEvent
    handleLinkClicks: handleLinkClicks
    handleFormSubmits: handleFormSubmits
    async: async
    isCurrentPageReloaded: isCurrentPageReloaded
    uuid: uuid
  }
)(document, window)

