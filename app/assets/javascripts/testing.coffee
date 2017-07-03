class PondoTesting
  constructor: (@window, @document, @body) ->
    @active = false
    @store = new PondoTestStore(@window.localStorage)
    @domLoadKey = 'pondoDomLoad'
    @fetchLoadKey = 'pondoFetchLoad'

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
    @document.on 'nitrolinks:before-visit', =>
      @markAsLoading('nitrolinks:before-visit')

    @document.on 'nitrolinks:load', (e) =>
      @markAsDoneLoading()
      @showLoads()

    @document.on 'nitrolinks:load-from-fetch', (e) =>
      @addToFetched(e.detail.url)

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

  addToArrayStored: (key, input) ->
    loads = @store.get(key, [])
    loads.push input
    @store.set(key, loads)

  showLoads: ->
    @showDomLoads()
    @showFetchLoads()

  domEl: ->
    $('#nitro-debugging .dom-loads')

  showDomLoads: ->
    @loadShower(@domEl(), @domLoadKey)

  loadShower: ($el, storeKey) ->
    loads = @store.get(storeKey, [])
    htmlStr = ''
    for load in loads
      htmlStr += "<li>#{load}</li>"
    $el.html(htmlStr)

  fetchEl: ->
    $('#nitro-debugging .fetch-loads')

  showFetchLoads: ->
    @loadShower(@fetchEl(), @fetchLoadKey)

  clearDomLoads: ->
    @store.remove(@domLoadKey)
    @store.remove(@fetchLoadKey)

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

  urlPath: (urlStr) ->
    url = new URL(urlStr)
    if url.origin == url.toString()
      url.pathname
    else
      url.toString().replace(url.origin, '')

class PondoTestStore
  constructor: (@localStore) ->
    console.log @localStore

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

