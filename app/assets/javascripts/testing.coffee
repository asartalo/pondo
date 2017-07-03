class PondoTesting
  constructor: (@window, @document, @body) ->
    @active = false
    @store = new PondoTestStore(@window.localStorage)
    @domLoadKey = 'pondoDomLoad'

  init: ->
    @listen()

  listen: ->
    @document.on 'nitrolinks:before-visit', =>
      @active = true
      @body.addClass('testing-visiting')

    @document.on 'nitrolinks:load', =>
      @active = false
      @body.removeClass('testing-visiting')
      @showDomLoads()

    $ =>
      return unless $('#nitro-debugging').is(':visible')
      console.log 'hey'
      loads = @store.get(@domLoadKey, [])
      loads.push @window.location.href
      @store.set(@domLoadKey, loads)
      @showDomLoads()

  showDomLoads: ->
    loads = @store.get(@domLoadKey, [])
    $history = $('#nitro-debugging .dom-loads')
    htmlStr = ''
    for load in loads
      htmlStr += "<li>#{load}</li>"
    $history.html(htmlStr)

  clearDomLoads: ->
    @store.remove(@domLoadKey)

  domLoadCount: ->
    @store.get(@domLoadKey, []).length

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

