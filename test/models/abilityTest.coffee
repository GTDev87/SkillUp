ability = null

describe "App.Ability", ->
  describe "fields", ->
    beforeEach (done) ->
      ability = App.Ability.build
        title: "A title"
        description: "A description"

      done()

    test "title", ->
      assert.ok ability.get("title")

    test "description", ->
      assert.ok ability.get("description")

  describe "relations", ->

