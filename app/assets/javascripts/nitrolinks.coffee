$(document).on 'click', 'a[href]', (e) ->
  link = $(e.currentTarget)
  url = link.attr('href')
  if urlIsInApp(url)
    e.preventDefault()
    requestUrl(url, 'GET')
    e.stopPropagation()

urlIsInApp = (url) ->
  true

xhrComplete = (url, method, pushState = true) ->
  (xhr, status) ->
    bodyCode = extractBodyCode(xhr.responseText)
    state = saveState(url, method, bodyCode)
    console.log '+', state
    renderState(bodyCode)
    window.history.pushState(state, null, url) if pushState

extractBodyCode = (text) ->
  code = $.trim(text)
  match = code.match(/<body[^>]*>([\s\S]+)<\/body>/)
  bodyCode = $.trim match[1]

requestUrl = (url, method, pushState = true) ->
  $.ajax(
    url: url
    method: method
    contentType: false
    complete: xhrComplete(url, method, pushState)
  )

$(window).on 'popstate', (e) ->
  state = e.originalEvent.state
  console.log '-', state
  stateObj = getState(state)
  if stateObj.content
    renderState(stateObj.content)
  else if stateObj.url && stateObj.method
    requestUrl(stateObj.url, stateObj.method)
  else
    location = window.location
    requestUrl(location.pathname + location.search, 'GET', false)

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

