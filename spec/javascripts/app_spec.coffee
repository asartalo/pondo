#= require jquery
#= require app

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


