###
describe 'SkillsController', ->
  controller = undefined
  skill = undefined
  url = undefined

  beforeEach (done) ->
    controller = App.SkillsController.create()
    agent.controller = controller
    Tower.start(done)

  afterEach ->
    Tower.stop()
    delete agent.controller

  describe 'routes', ->
    test 'index', ->
      assert.equal urlFor(App.Skill), "/skills"

    test 'new', ->
      skill = App.Skill.build()
      assert.equal urlFor(skill, action: 'new'), "/skills/new"

    test 'show', ->
      skill = new App.Skill(id: 1)
      assert.equal urlFor(skill), "/skills/#{skill.get('id')}"

    test 'edit', ->
      skill = new App.Skill(id: 1)
      assert.equal urlFor(skill, action: 'edit'), "/skills/#{skill.get('id')}/edit"

  describe '#index', ->
    beforeEach (done) ->
      factory 'skill', (error, record) =>
        skill = record
        done()

    test 'render json', (done) ->
      get urlFor(App.Skill), format: "json", (request) ->
        assert.equal @headers["Content-Type"], 'application/json'

        done()

  describe '#new', ->

  describe '#create', ->
    beforeEach ->
      url = urlFor(App.Skill)

    test 'params', (done) ->
      params = {}

      post url, format: "json", params: params, (response) ->
        App.Skill.count (error, count) =>
          assert.equal count, 1
          done()

  describe "#show", ->

  describe "#edit", ->

  describe "#update", ->

  describe "#destroy", ->
###