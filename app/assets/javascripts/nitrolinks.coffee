((document, window) ->
  nitro = {
    appHost: window.location.origin
  }

  ifElseFn = (test, fn1, fn2) ->
    if test then fn1 else fn2

  ifFn = (test, fn) ->
    fn if test

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
      console.log 'click: ', link.href
      url = new URL(link.href)
      fn(url, e)

  cacheStore = {}
  cache = (key, value) ->
    cacheStore[key] = value

  getCache = (key) ->
    cacheStore[key]

  urlPath = (urlStr) ->
    url = new URL(urlStr)
    if url.origin == url.toString()
      url.pathname
    else
      url.toString().replace(url.origin, '')

  async = (fn, interval = 0) ->
    ->
      args = arguments
      setTimeout(
        ->
          fn.apply(fn, args)
        interval
      )


  # NITRO-SPECIFIC
  isUrlAllowed = (url) ->
    url.origin == nitro.appHost

  onPopState = (fn) ->
    window.addEventListener 'popstate',
      (e) ->
        state = e.state
        return unless state
        stateObj = getState(state)
        fn(stateObj)



  whenReady ->
    appHost = window.location.origin

  handleLinkClicks (url, e) ->
    if isUrlAllowed(url)
      e.preventDefault()
      visit(url.pathname, 'GET')
      e.stopPropagation()

  fetchComplete = (url, method, pushState = true) ->
    (response) ->
      return unless response.ok
      response.text().then (contents) ->
        bodyCode = extractBodyCode(contents)
        return unless bodyCode
        if response.redirected && response.headers.has("nitrolinks-location")
          location = urlPath(response.headers.get("nitrolinks-location"))
        else
          location = url

        state = saveState(location, method, bodyCode)
        renderState(bodyCode)
        window.history.pushState(state, null, location) if pushState
        triggerEvent 'nitrolinks:load-from-fetch', url: location
        triggerEvent 'nitrolinks:load', url: location

  extractBodyCode = (text) ->
    code = text.trim()
    match = code.match(/<body[^>]*>([\s\S]+)<\/body>/)
    return null unless match
    (match[1]).trim()

  visit = (url, method, pushState = true) ->
    event = triggerEvent 'nitrolinks:before-visit'
    return if event.defaultPrevented
    fetch(url, nitroFetchOptions(method)).then(
      fetchComplete(url, method, pushState)
    ).catch( (error, a) ->
      window.location = url
    )

  visitCached = (stateObj) ->
    triggerEvent 'nitrolinks:before-visit'
    renderState(stateObj.content)
    triggerEvent 'nitrolinks:load-from-cache', url: stateObj.url
    triggerEvent 'nitrolinks:load', url: stateObj.url

  nitroFetchOptions = (method) ->
    method: method
    redirect: 'follow'
    credentials: 'include'
    headers:
      "nitrolinks-referrer": window.location.href

  onPopState (stateObj) ->
      if stateObj.content
        debugger
        visitCached(stateObj)
      else if stateObj.url && stateObj.method
        visit(stateObj.url, stateObj.method, false)
      else
        visit(stateObj.url, 'GET', false)

  renderState = (content) ->
    document.getElementsByTagName('body')[0].innerHTML = content

  saveState = (url, method, value) ->
    key = "#{method}:#{url}"
    cache(key, value)
    return key

  getState = (state) ->
    if state
      parsedState = parseState(state)
      {
        method: parsedState.method
        url: parsedState.url
        content: getCache(state)
      }
    else
      {
        method: null
        url: null
        content: null
      }

  parseState = (state) ->
    match = (state || '').match(/^(\w+):(.+)$/)
    method: match[1], url: match[2]

)(document, window)
