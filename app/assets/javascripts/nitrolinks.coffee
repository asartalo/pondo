((document, window) ->
  nitro = {
    appHost: window.location.origin
  }

  ifElseFn = (test, fn1, fn2) ->
    if test then fn1 else fn2

  ifFn = (test, fn) ->
    fn if test

  merge = (a, b) ->
    Object.assign(a, b)

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

  cache = (key, value) ->
    window.sessionStorage.setItem(key, JSON.stringify(value))

  getCache = (key) ->
    JSON.parse(window.sessionStorage.getItem(key))

  urlPath = (urlStr) ->
    url = new URL(urlStr)
    if url.origin == url.toString()
      url.pathname
    else
      url.toString().replace(url.origin, '')

  fullPath = (urlStr) ->
    if urlStr.indexOf(nitro.appHost) != 0
      "#{nitro.appHost}/#{urlStr.match(/^\/?(.+$)/)[1]}"
    else
      urlStr

  async = (fn, interval = 0) ->
    ->
      args = arguments
      setTimeout(
        ->
          fn.apply(fn, args)
        interval
      )

  getBodyElement = ->
    document.getElementsByTagName('body')[0]

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


  # NITRO-SPECIFIC
  isUrlAllowed = (url) ->
    url.origin == nitro.appHost

  pushTheState = (state, location) ->
    window.history.pushState(state, null, location)

  replaceTheState = (state, location) ->
    window.history.replaceState(state, null, location)

  onPopState = (fn) ->
    window.addEventListener 'popstate',
      (e) ->
        state = e.state
        return unless state
        stateObj = getState(state)
        fn(stateObj)


  whenReady ->
    state = window.history.state
    if hasState(state)
      loadState(getState(state))
    else
      location = urlPath(window.location)
      method = 'get'
      bodyCode = getBodyElement().innerHTML
      state = saveState(location, method, bodyCode)
      replaceTheState(state, location)

  handleLinkClicks (url, e) ->
    if isUrlAllowed(url)
      e.preventDefault()
      visit(url, method: 'get')
      e.stopPropagation()

  handleFormSubmits (form, e) ->
    url = new URL(form.action)
    method = form.method.toLowerCase()
    if method == 'get'
      url.search = $(form).serialize()
    if isUrlAllowed(url)
      e.preventDefault()
      visit(url, method: form.method)
      e.stopPropagation()

  fetchComplete = (url, theOptions = {}) ->
    options = merge({method: 'get', pushState: true}, theOptions)
    (response) ->
      return unless response.ok
      method = options.method
      pushState = options.pushState
      response.text().then (contents) ->
        bodyCode = extractBodyCode(contents)
        return unless bodyCode
        if response.redirected && response.headers.has("nitrolinks-location")
          location = urlPath(response.headers.get("nitrolinks-location"))
        else
          location = urlPath(url)

        state = saveState(location, method, bodyCode)
        renderState(bodyCode)
        pushTheState(state, location) if pushState

        triggerEvent 'nitrolinks:load-from-fetch', url: location
        triggerEvent 'nitrolinks:load', url: location

  extractBodyCode = (text) ->
    code = text.trim()
    match = code.match(/<body[^>]*>([\s\S]+)<\/body>/)
    return null unless match
    (match[1]).trim()

  visit = (url, theOptions = {}) ->
    options = merge({method: 'get', pushState: true}, theOptions)
    event = triggerEvent 'nitrolinks:before-visit'
    return if event.defaultPrevented
    fetch(url, nitroFetchOptions(options)).then(
      fetchComplete(url, options)
    ).catch( (error, a) ->
      window.location = url
    )

  visitCached = (stateObj) ->
    triggerEvent 'nitrolinks:before-visit'
    renderState(stateObj.content)
    triggerEvent 'nitrolinks:load-from-cache', url: stateObj.url
    triggerEvent 'nitrolinks:load', url: stateObj.url

  nitroFetchOptions = (options) ->
    method: options.method
    redirect: 'follow'
    credentials: 'include'
    body: options.body
    headers:
      "nitrolinks-referrer": window.location.href

  loadState = (stateObj) ->
    if stateObj.url
      url = new URL(fullPath(stateObj.url))
    else
      url = false
    if stateObj.content
      visitCached(stateObj)
    else if url && stateObj.method
      visit(url, method: stateObj.method, pushState: false)
    else if url
      visit(url, method: 'get', pushState: false)
    else
      visit(window.location.href, method: 'get', pushState: false)

  onPopState loadState

  renderState = (content) ->
    getBodyElement().innerHTML = content

  saveState = (url, method, body) ->
    # key = "#{method}:#{url}:#{uuid()}"
    key = uuid()
    cache(key, url: url, method: method, body: body)
    return key

  getState = (state) ->
    savedState = getCache(state)
    if state && savedState
      {
        method: savedState.method
        url: savedState.url
        content: savedState.body
      }
    else
      {
        method: null
        url: null
        content: null
      }

  hasState = (state) ->
    savedState = getCache(state)
    state && savedState

  parseState = (state) ->
    match = (state || '').match(/^(\w+):(.+)$/)
    method: match[1], url: match[2]

)(document, window)
