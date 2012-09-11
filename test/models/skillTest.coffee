skill = null

describe "App.Skill", ->
  describe "fields", ->
    beforeEach (done) ->
      skill = new App.Skill
        description: "A description"
        title: "A title"

      done()

    test "description", ->
      assert.ok skill.get("description")

    test "title", ->
      assert.ok skill.get("title")

  describe "relations", ->

