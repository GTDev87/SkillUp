aptitude = null

describe "App.Aptitude", ->
  describe "fields", ->
    beforeEach (done) ->
      aptitude = new App.Aptitude
        level: "A level"

      done()

    test "level", ->
      assert.ok aptitude.get("level")

  describe "relations", ->

