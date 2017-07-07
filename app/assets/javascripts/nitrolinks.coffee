# requires set-dom
@nitro = ((document, window, pu, setDOM) ->
  getCsrfToken = ->
    pu.getContentOfElement('meta[name="csrf-token"]')

  getCsrfParam = ->
    pu.getContentOfElement('meta[name="csrf-param"]')

  nitro = {
    appHost: window.location.origin
    csrfToken: getCsrfToken()
    csrfParam: getCsrfParam()
  }

  # TODO: This holds too much information to just store in sessionStorage
  cache = (key, value) ->
    window.sessionStorage.setItem(key, JSON.stringify(value))

  getCache = (key) ->
    JSON.parse(window.sessionStorage.getItem(key))

  getAppElement = ->
    document.getElementsByTagName('html')[0]

  isUrlAllowed = (url) ->
    url.origin == nitro.appHost && !isHashChange(url)

  isHashChange = (url) ->
    current = window.location
    url.hash != current.hash && url.pathname == current.pathname

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

  pushTheState = (state, location) ->
    window.history.pushState(state, null, location)

  replaceTheState = (state, location) ->
    window.history.replaceState(state, null, location)

  onPopState = (fn) ->
    window.addEventListener 'popstate',
      (e) ->
        state = e.state
        return unless state
        fn(getState(state))


  pu.whenReady ->
    state = window.history.state
    if hasState(state) && !pu.isCurrentPageReloaded()
      loadState(getState(state))
    else
      location = urlPath(window.location)
      method = 'get'
      appCode = getAppElement().outerHTML
      state = saveState(location, method, appCode)
      replaceTheState(state, location)

  pu.handleLinkClicks (url, e) ->
    if isUrlAllowed(url)
      e.preventDefault()
      visit(url, method: 'get')
      e.stopPropagation()

  pu.handleFormSubmits (form, e) ->
    url = new URL(form.action)
    data = null
    method = form.method.toLowerCase()
    if method == 'get'
      url.search = $(form).serialize()
    else if method == 'post'
      data = new FormData(form)
    if isUrlAllowed(url)
      e.preventDefault()
      visit(url, method: form.method, body: data)
      e.stopPropagation()

  fetchComplete = (url, theOptions = {}) ->
    options = pu.merge({method: 'get', pushState: true}, theOptions)
    (response) ->
      return unless response.ok
      method = options.method
      pushState = options.pushState
      response.text().then (contents) ->
        pageSource = extractPageSource(contents)
        return unless pageSource
        if response.redirected && response.headers.has("nitrolinks-location")
          location = urlPath(response.headers.get("nitrolinks-location"))
        else
          location = urlPath(url)

        state = saveState(location, method, pageSource)
        renderState(pageSource)
        pushTheState(state, location) if pushState

        pu.triggerEvent 'nitrolinks:load-from-fetch', url: location
        pu.triggerEvent 'nitrolinks:load', url: location

  extractPageSource = (text) ->
    code = text.trim()
    match = code.match(/<html[^>]*>([\s\S]+)<\/html>/)
    return null unless match
    (match[0]).trim()

  visit = (url, theOptions = {}) ->
    options = pu.merge({method: 'get', pushState: true}, theOptions)
    event = pu.triggerEvent 'nitrolinks:before-visit'
    return if event.defaultPrevented
    fetch(url, nitroFetchOptions(options)).then(
      fetchComplete(url, options)
    ).catch( (error, a) ->
      window.location = url
    )

  visitCached = (stateObj) ->
    pu.triggerEvent 'nitrolinks:before-visit'
    renderState(stateObj.content)
    pu.triggerEvent 'nitrolinks:load-from-cache', url: stateObj.url
    pu.triggerEvent 'nitrolinks:load', url: stateObj.url

  nitroFetchOptions = (options) ->
    headers = {
      "nitrolinks-referrer": window.location.href
      "accept": "text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8"
    }
    if options.method == 'post'
      headers["x-csrf-token"] = getCsrfToken()
    method: options.method
    redirect: 'follow'
    credentials: 'include'
    body: options.body
    headers: headers


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

  onPopState(loadState)

  renderState = (content) ->
    setDOM(getAppElement(), preloadContent(content))

  preloadContent = (content) ->
    # TODO: Is there a better way to do this?
    content.replace('<html', '<html class="js"')

  saveState = (url, method, body) ->
    key = pu.uuid()
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

  return {
  }
)(document, window, pu, setDOM)
