mission = null

describe "App.Mission", ->
  describe "fields", ->
    beforeEach (done) ->
      mission = App.Mission.build
        title: "A title"
        description: "A description"

      done()

    test "title", ->
      assert.ok mission.get("title")

    test "description", ->
      assert.ok mission.get("description")
      
  describe "validation", ->
    test "no title", ->
      mission = App.Mission.build
      
      #assert.ok mission.get("title")

  describe "relations", ->