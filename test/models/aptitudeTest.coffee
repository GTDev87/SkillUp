aptitude = null

describe "App.Aptitude", ->
  describe "fields", ->
    beforeEach (done) ->
      aptitude = App.Aptitude.build
        level: 10

      done()

    test "level", ->
      assert.ok aptitude.get("level")

  describe "relations", ->

