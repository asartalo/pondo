# Pondo Utilities
@pu = ((document, window) ->
  whenReady = (fn) ->
    document.addEventListener("DOMContentLoaded", fn)
    ->
      document.removeEventListener("DOMContentLoaded", fn)

  ifElseFn = (test, fn1, fn2) ->
    if test then fn1 else fn2

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

  animationEndEvents = 'webkitAnimationEnd mozAnimationEnd MSAnimationEnd oanimationend animationend'
  animateCss = (el, animation, fn) ->
    classList = el.classList
    classList.add('animated')
    classList.add(animation)
    listenOnce el, animationEndEvents, ->
      fn() if fn
      classList.remove('animated')
      classList.remove(animation)

  listenOnce = (el, eventsStr, fn) ->
    events = eventsStr.split(/\s/)
    unloader = ->
      for event in events
        el.removeEventListener(event, handler)

    handler = (e) ->
      fn.call el, e
      unloader()

    for event in events
      el.addEventListener event, handler

    unloader

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

  eventListen = (event, handler) ->
    document.addEventListener event, (e) ->
      handler.call document, e

  triggerEvent = (event, data = {}) ->
    triggerElementEvent(document, event, data)

  triggerElementEvent = (el, event, data = {}) ->
    el.dispatchEvent eventFactory(event, data)
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
    window.performance.navigation.type == 1

  select = (selector) ->
    document.querySelectorAll(selector)

  selectAnd = (selector, fn) ->
    found = select(selector)
    fn.call(fn, found)

  selectAndEach = (selector, fn) ->
    selectAnd selector, (elements) ->
      for element in elements
        fn.call(fn, element)

  hide = (el) ->
    el.style.display = 'none'

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

  doc = document
  docEl = doc.documentElement
  requestFullScreenFn = docEl.requestFullscreen or docEl.mozRequestFullScreen or docEl.webkitRequestFullScreen or docEl.msRequestFullscreen
  cancelFullScreenFn = doc.exitFullscreen or doc.mozCancelFullScreen or doc.webkitExitFullscreen or doc.msExitFullscreen

  isFullScreen = ->
    doc.fullscreenElement || doc.mozFullScreenElement || doc.webkitFullscreenElement || doc.msFullscreenElement

  requestFullScreen = ->
    unless isFullScreen()
      requestFullScreenFn.call docEl

  cancelFullScreen = ->
    if isFullScreen()
      cancelFullScreenFn.call doc

  return {
    getContentOfElement: getContentOfElement
    ifElseFn: ifElseFn
    merge: merge
    listenOnce: listenOnce
    createEvent: eventFactory
    whenReady: whenReady
    eventDelegate: eventDelegate
    eventListen: eventListen
    triggerEvent: triggerEvent
    triggerElementEvent: triggerElementEvent
    handleLinkClicks: handleLinkClicks
    handleFormSubmits: handleFormSubmits
    async: async
    isCurrentPageReloaded: isCurrentPageReloaded
    uuid: uuid
    animateCss: animateCss
    select: select
    selectAnd: selectAnd
    selectAndEach: selectAndEach
    hide: hide
    requestFullScreen: requestFullScreen
    cancelFullScreen: cancelFullScreen
  }
)(document, window)

