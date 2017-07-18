#= require jquery
#= require app

sleep = (ms) ->
  new Promise (resolve) ->
    setTimeout(resolve, ms)
    return

describe 'app', ->
  describe 'load', ->
    beforeEach =>
      @state = 'nil state'
      @matched = null
      loader = (el) =>
        @state = "loaded"
        @matched = el
      unloader = (el) =>
        @state = "unloaded"
        @matched = el

      app.load '.foo-element', loader, unloader

    describe 'when there is no matching element', =>
      describe 'and load event is triggered', =>
        beforeEach =>
          pu.triggerEvent 'nitrolinks:load'

        it "doesn't call anything", =>
          expect(@state).toEqual('nil state')

      describe 'and unload event is triggered', =>
        beforeEach =>
          pu.triggerEvent 'nitrolinks:visit'

        it "doesn't call anything", =>
          expect(@state).toEqual('nil state')

    describe 'when there is a matching element', =>
      beforeEach =>
        @el = document.createElement('div')
        @el.className = 'foo-element'
        @body = document.getElementsByTagName('body')[0]
        @body.appendChild(@el)

      afterEach =>
        @body.removeChild(@el)

      describe 'and load event is triggered', =>
        beforeEach =>
          pu.triggerEvent 'nitrolinks:load'

        it "calls loader", =>
          expect(@state).toEqual('loaded')

        it "passes matching elements to loader", =>
          expect(@matched.length).toEqual(1)
          expect(@matched[0]).toEqual(@el)

      describe 'and unload event is triggered', =>
        beforeEach =>
          pu.triggerEvent 'nitrolinks:visit'

        it "calls loader", =>
          expect(@state).toEqual('unloaded')

        it "passes matching elements to loader", =>
          expect(@matched.length).toEqual(1)
          expect(@matched[0]).toEqual(@el)

  describe 'app.hashChange', ->
    beforeEach =>
      @subject = false
      app.hashChange(
        'foo',
        =>
          @subject = 'bar'
        =>
          @subject = 'baz'
      )

    # describe 'when a non-matching hash change is triggered', =>
    #   beforeEach =>
    #     window.history.pushState('1', null, '#zoo')

    #   afterEach =>
    #     window.history.back()

    #   it 'does not do anything', =>
    #     expect(@subject).toEqual(false)

    describe 'when a matching hash change is triggered', =>
      beforeEach =>
        # window.location.hash = "foo"

      afterEach =>
        # window.history.back()

      it 'executes in func', =>
        pending("Unable to properly test this")
        expect(@subject).toEqual('bar')


