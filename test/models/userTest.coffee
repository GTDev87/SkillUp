user = null

describe "App.User", ->
  describe "fields", ->
    beforeEach (done) ->
      user = App.User.build
        email: "A email"
        username: "A username"

      done()

    test "email", ->
      assert.ok user.get("email")

    test "username", ->
      assert.ok user.get("username")

  describe "relations", ->