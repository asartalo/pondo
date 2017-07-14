#= require pu

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
      console.log "READY: ", @subject

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
