#= require pu

describe 'pu', ->
  describe 'pu.ifElseFn', ->
    beforeEach =>
      @subject = =>
        (pu.ifElseFn @bool,
          ->
            1
          ->
            2
        )()

    describe 'when true', =>
      beforeEach =>
        @bool = true

      it 'returns first function', =>
        expect(@subject()).toEqual(1)

    describe 'when false', =>
      beforeEach =>
        @bool = false

      it 'returns second function', =>
        expect(@subject()).toEqual(2)

  describe 'pu.merge', ->
    beforeEach =>
      @subject = pu.merge({foo: 1, bar: 2}, { bar: 3, zoo: 4 })

    it 'merges values', =>
      expect(@subject.foo).toEqual(1)
      expect(@subject.bar).toEqual(3)
      expect(@subject.zoo).toEqual(4)

  describe 'pu.whenReady', ->
    beforeEach =>
      @subject = 1
      @unloader = pu.whenReady =>
        @subject += 1

    afterEach =>
      @subject = 1
      @unloader() if @unloader

    describe 'when "DOMContentLoaded" event has not yet fired', =>
      it 'does nothing yet', =>
        expect(@subject).toEqual(1)

    describe 'when "DOMContentLoaded" has fired', =>
      beforeEach =>
        pu.triggerEvent "DOMContentLoaded"

      it 'executes listener', =>
        expect(@subject).toEqual(2)

  describe 'pu.listenOnce', ->
    beforeEach =>
      @el = document.createElement('div')
      @subject = 1
      @event = null
      pu.listenOnce @el, 'click event2', (e) =>
        @subject += 1
        @event = e

    afterEach =>
      @el = null
      @event = null

    describe 'when the event is triggered', =>
      beforeEach =>
        pu.triggerElementEvent(@el, 'click')

      it 'executes the callback', =>
        expect(@subject).toEqual(2)

    describe 'when the other event is triggered', =>
      beforeEach =>
        pu.triggerElementEvent(@el, 'event2')

      it 'still executes the callback', =>
        expect(@subject).toEqual(2)

    describe 'when the element event is triggered twice', =>
      beforeEach =>
        pu.triggerElementEvent(@el, 'click')
        pu.triggerElementEvent(@el, 'click')

      it 'executes the callback only once', =>
        expect(@subject).toEqual(2)

    describe 'when multiple events are triggered', =>
      beforeEach =>
        pu.triggerElementEvent(@el, 'event2')
        pu.triggerElementEvent(@el, 'click')

      it 'executes the callback only once', =>
        expect(@subject).toEqual(2)

  describe 'pu.animateCss', ->
    beforeEach =>
      @el = document.createElement('div')
      @marker = 1
      @subject = @el.classList
      pu.animateCss @el, 'myAnimation', =>
        @marker += 1

    afterEach =>
      @el = null

    it 'adds animation classes to element', =>
      expect(@subject.contains("animated")).toBeTruthy()
      expect(@subject.contains("myAnimation")).toBeTruthy()

    describe 'when animation ends', =>
      describe "with webkitAnimationEnd", =>

        beforeEach =>
          pu.triggerElementEvent(@el, 'webkitAnimationEnd')

        it 'calls callback', =>
          expect(@marker).toEqual(2)

        it 'removes animation classes', =>
          expect(@subject.contains("animated")).toBeFalsy()
          expect(@subject.contains("myAnimation")).toBeFalsy()

