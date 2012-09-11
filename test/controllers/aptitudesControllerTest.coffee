describe 'AptitudesController', ->
  controller = undefined
  aptitude = undefined
  url = undefined

  beforeEach (done) ->
    controller = App.AptitudesController.create()
    agent.controller = controller
    Tower.start(done)

  afterEach ->
    Tower.stop()
    delete agent.controller

  describe 'routes', ->
    test 'index', ->
      assert.equal urlFor(App.Aptitude), "/aptitudes"

    test 'new', ->
      aptitude = App.Aptitude.build()
      assert.equal urlFor(aptitude, action: 'new'), "/aptitudes/new"

    test 'show', ->
      aptitude = new App.Aptitude(id: 1)
      assert.equal urlFor(aptitude), "/aptitudes/#{aptitude.get('id')}"

    test 'edit', ->
      aptitude = new App.Aptitude(id: 1)
      assert.equal urlFor(aptitude, action: 'edit'), "/aptitudes/#{aptitude.get('id')}/edit"

  describe '#index', ->
    beforeEach (done) ->
      factory 'aptitude', (error, record) =>
        aptitude = record
        done()

    test 'render json', (done) ->
      get urlFor(App.Aptitude), format: "json", (request) ->
        assert.equal @headers["Content-Type"], 'application/json'

        done()

  describe '#new', ->

  describe '#create', ->
    beforeEach ->
      url = urlFor(App.Aptitude)

    test 'params', (done) ->
      params = {}

      post url, format: "json", params: params, (response) ->
        App.Aptitude.count (error, count) =>
          assert.equal count, 1
          done()

  describe "#show", ->

  describe "#edit", ->

  describe "#update", ->

  describe "#destroy", ->
