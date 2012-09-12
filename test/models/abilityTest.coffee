ability = null

describe "App.Ability", ->
  describe "fields", ->
    beforeEach (done) ->
      ability = new App.Ability
        title: "A title"
        description: "A description"

      done()

    test "title", ->
      assert.ok ability.get("title")

    test "description", ->
      assert.ok ability.get("description")

  describe "relations", ->

