task = null

describe "App.Task", ->
  describe "fields", ->
    beforeEach (done) ->
      task = new App.Task
        title: "A title"
        description: "A description"

      done()

    test "title", ->
      assert.ok task.get("title")

    test "description", ->
      assert.ok task.get("description")

  describe "relations", ->

