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

  describe "validation", ->
    test "no title", ->
      ability = App.Ability.create
        title: "A title"
        description: "A description"
      
      console.log("ability.id " + ability.id)
      console.log("ability created is " + ability)
     
      foundAbility = App.Ability.find(ability.id)
      console.log(foundAbility)
      
      #console.log(ability.id)
      #console.log(foundAbility.id)
      
      #assert.isNull ability.get("title")
      #assert.isNull ability.get("description")
    
  describe "relations", ->

