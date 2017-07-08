class PondoTesting
  constructor: (@window, @document, @body) ->
    @active = false
    @store = new PondoTestStore(@window.localStorage)
    @domLoadKey = 'pondoDomLoad'
    @fetchLoadKey = 'pondoFetchLoad'
    @cacheLoadKey = 'pondoCacheLoad'
    @errors = []

  init: ->
    @listen()

  markAsLoading: (from)->
    console.log "loading - #{from}"
    @active = true
    @body.addClass('testing-visiting')

  markAsDoneLoading: ->
    console.log 'DONE: loading'
    @active = false
    @body.removeClass('testing-visiting')

  listen: ->
    @document.on 'nitrolinks:visit', =>
      @markAsLoading('nitrolinks:visit')

    @document.on 'nitrolinks:load', (e) =>
      @markAsDoneLoading()
      @showLoads()

    @document.on 'nitrolinks:load-from-fetch', (e) =>
      @addToFetched(e.detail.url)

    @document.on 'nitrolinks:load-from-cache', (e) =>
      @addToCached(e.detail.url)

    @window.addEventListener 'error', (e) =>
      @addToErrors(e)

    $ =>
      return unless $('#nitro-debugging').is(':visible')
      @addToLoaded(@window.location.href)
      @showLoads()
      @markAsDoneLoading()

    # @window.addEventListener 'popstate', (e) =>
    #   @markAsLoading('popstate')
    #   return true

  addToFetched: (url) ->
    @addToArrayStored(@fetchLoadKey, url)

  addToLoaded: (url) ->
    @addToArrayStored(@domLoadKey, url)

  addToCached: (url) ->
    @addToArrayStored(@cacheLoadKey, url)

  addToArrayStored: (key, input) ->
    loads = @store.get(key, [])
    loads.push input
    @store.set(key, loads)

  addToErrors: (e) ->
    if e.error
      @errors.push e.error.message
    else
      @errors.push e
    console.log e
    @loadShowerFromCollection(@errorsEl(), @errors)

  showLoads: ->
    @showDomLoads()
    @showFetchLoads()
    @showCacheLoads()

  errorsEl: ->
    $('#nitro-debugging .javascript-errors')

  domEl: ->
    $('#nitro-debugging .dom-loads')

  showDomLoads: ->
    @loadShowerFromCollection(@domEl(), @errors)

  loadShower: ($el, storeKey) ->
    @loadShowerFromCollection($el, @store.get(storeKey, []))

  loadShowerFromCollection: ($el, loads) ->
    htmlStr = ''
    for load in loads
      htmlStr += "<li>#{load}</li>"
    $el.html(htmlStr)

  fetchEl: ->
    $('#nitro-debugging .fetch-loads')

  showFetchLoads: ->
    @loadShower(@fetchEl(), @fetchLoadKey)

  cacheEl: ->
    $('#nitro-debugging .cache-loads')

  showCacheLoads: ->
    @loadShower(@cacheEl(), @cacheLoadKey)

  clearDomLoads: ->
    @store.remove(@domLoadKey)
    @clearSessionLoads()

  clearSessionLoads: ->
    @store.remove(@fetchLoadKey)
    @store.remove(@cacheLoadKey)

  domLoadCount: ->
    @store.get(@domLoadKey, []).length

  isPageFetched: (path) ->
    el = @fetchEl()
    lastItem = el.find('li').last()
    if lastItem.length == 1
      lastItem.text() == path
    else
      false

  isPageNormallyLoaded: (path) ->
    el = @domEl()
    lastItem = el.find('li').last()
    if lastItem.length == 1
      @urlPath(lastItem.text()) == path
    else
      false

  isPageCacheRestored: (path) ->
    el = @cacheEl()
    lastItem = el.find('li').last()
    if lastItem.length == 1
      lastItem.text() == path
    else
      false

  urlPath: (urlStr) ->
    url = new URL(urlStr)
    if url.origin == url.toString()
      url.pathname
    else
      url.toString().replace(url.origin, '')

  hasJavascriptErrors: ->
    @errorsEl().find('li').length > 0

class PondoTestStore
  constructor: (@localStore) ->

  set: (key, value) ->
    @localStore.setItem(key, JSON.stringify(value))

  get: (key, def = null) ->
    stored = @localStore.getItem(key)
    if stored
      JSON.parse stored
    else
      def

  remove: (key) ->
    @localStore.removeItem(key)

@pondoTesting = new PondoTesting(window, $(document), $('body'))
@pondoTesting.init()

