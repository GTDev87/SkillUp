mission = null

describe "App.Mission", ->
  describe "fields", ->
    beforeEach (done) ->
      mission = new App.Mission
        title: "A title"
        description: "A description"

      done()

    test "title", ->
      assert.ok mission.get("title")

    test "description", ->
      assert.ok mission.get("description")

  describe "relations", ->

