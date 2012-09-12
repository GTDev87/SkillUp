describe 'MissionsController', ->
  controller = undefined
  mission = undefined
  url = undefined

  beforeEach (done) ->
    controller = App.MissionsController.create()
    agent.controller = controller
    Tower.start(done)

  afterEach ->
    Tower.stop()
    delete agent.controller

  describe 'routes', ->
    test 'index', ->
      assert.equal urlFor(App.Mission), "/missions"

    test 'new', ->
      mission = App.Mission.build()
      assert.equal urlFor(mission, action: 'new'), "/missions/new"

    test 'show', ->
      mission = new App.Mission(id: 1)
      assert.equal urlFor(mission), "/missions/#{mission.get('id')}"

    test 'edit', ->
      mission = new App.Mission(id: 1)
      assert.equal urlFor(mission, action: 'edit'), "/missions/#{mission.get('id')}/edit"

  describe '#index', ->
    beforeEach (done) ->
      factory 'mission', (error, record) =>
        mission = record
        done()

    test 'render json', (done) ->
      get urlFor(App.Mission), format: "json", (request) ->
        assert.equal @headers["Content-Type"], 'application/json'

        done()

  describe '#new', ->

  describe '#create', ->
    beforeEach ->
      url = urlFor(App.Mission)

    test 'params', (done) ->
      params = {}

      post url, format: "json", params: params, (response) ->
        App.Mission.count (error, count) =>
          assert.equal count, 1
          done()

  describe "#show", ->

  describe "#edit", ->

  describe "#update", ->

  describe "#destroy", ->
