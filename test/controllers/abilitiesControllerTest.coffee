describe 'AbilitiesController', ->
  controller = undefined
  ability = undefined
  url = undefined

  beforeEach (done) ->
    controller = App.AbilitiesController.create()
    agent.controller = controller
    Tower.start(done)

  afterEach ->
    Tower.stop()
    delete agent.controller

  describe 'routes', ->
    test 'index', ->
      assert.equal urlFor(App.Ability), "/abilities"

    test 'new', ->
      ability = App.Ability.build()
      assert.equal urlFor(ability, action: 'new'), "/abilities/new"

    test 'show', ->
      ability = new App.Ability(id: 1)
      assert.equal urlFor(ability), "/abilities/#{ability.get('id')}"

    test 'edit', ->
      ability = new App.Ability(id: 1)
      assert.equal urlFor(ability, action: 'edit'), "/abilities/#{ability.get('id')}/edit"

  describe '#index', ->
    beforeEach (done) ->
      factory 'ability', (error, record) =>
        ability = record
        done()

    test 'render json', (done) ->
      get urlFor(App.Ability), format: "json", (request) ->
        assert.equal @headers["Content-Type"], 'application/json'

        done()

  describe '#new', ->

  describe '#create', ->
    beforeEach ->
      url = urlFor(App.Ability)

    test 'params', (done) ->
      params = {}

      post url, format: "json", params: params, (response) ->
        App.Ability.count (error, count) =>
          assert.equal count, 1
          done()

  describe "#show", ->

  describe "#edit", ->

  describe "#update", ->

  describe "#destroy", ->
