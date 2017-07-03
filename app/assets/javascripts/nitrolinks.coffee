$ ->
  appHost = window.location.origin

$(document).on 'click', 'a[href]', (e) ->
  link = $(e.currentTarget)
  url = link.attr('href')
  if urlIsInApp(url)
    $(document).trigger 'nitrolinks:before-visit'
    e.preventDefault()
    requestUrl(url, 'GET')
    e.stopPropagation()

urlIsInApp = (url) ->
  url.match(/^\/.+/) || false

fetchComplete = (url, method, pushState = true) ->
  (response) ->
    return unless response.ok
    response.text().then (contents) ->
      bodyCode = extractBodyCode(contents)
      return unless bodyCode
      if response.redirected && response.headers.has("nitrolinks-location")
        location = response.headers.get("nitrolinks-location")
      else
        location = url

      state = saveState(location, method, bodyCode)
      renderState(bodyCode)
      window.history.pushState(state, null, location) if pushState
      $(document).trigger 'nitrolinks:load'

extractBodyCode = (text) ->
  code = $.trim(text)
  match = code.match(/<body[^>]*>([\s\S]+)<\/body>/)
  return null unless match
  $.trim match[1]

requestUrl = (url, method, pushState = true) ->
  options =
    method: method
    redirect: 'follow'
    credentials: 'include'
    headers: customHeaders()

  fetch(url, options).then(
    fetchComplete(url, method, pushState)
  ).catch( (error, a) ->
    window.location = url
  )

customHeaders = ->
  {
    "nitrolinks-referrer": window.location.href
  }

$(window).on 'popstate', (e) ->
  state = e.originalEvent.state
  console.log '-', state
  stateObj = getState(state)
  if stateObj.content
    renderState(stateObj.content)
  else if stateObj.url && stateObj.method
    requestUrl(stateObj.url, stateObj.method, false)
  else
    requestUrl(stateObj.url, 'GET', false)

renderState = (content) ->
  $('body').html $.parseHTML(content)

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

cacheStore = {}
cache = (key, value) ->
  cacheStore[key] = value

getCache = (key) ->
  cacheStore[key]

