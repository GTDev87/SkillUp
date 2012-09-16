aptitude = null

describe "App.Aptitude", ->
  describe "fields", ->
    beforeEach (done) ->
      aptitude = App.Aptitude.build
        level: 10

      done()

    test "level", ->
      assert.ok aptitude.get("level")

  describe "validation", ->
    test "level not number", ->
      aptitude = App.Aptitude.build
        level: "Not a number"
      
      assert.ok !aptitude.get("level")
 
      
  describe "relations", ->

