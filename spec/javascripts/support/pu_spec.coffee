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

