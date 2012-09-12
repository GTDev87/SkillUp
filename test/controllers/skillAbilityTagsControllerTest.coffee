###
describe 'SkillAbilityTagsController', ->
  controller = undefined
  skillAbilityTag = undefined
  url = undefined

  beforeEach (done) ->
    controller = App.SkillAbilityTagsController.create()
    agent.controller = controller
    Tower.start(done)

  afterEach ->
    Tower.stop()
    delete agent.controller

  describe 'routes', ->
    test 'index', ->
      assert.equal urlFor(App.SkillAbilityTag), "/skillAbilityTags"

    test 'new', ->
      skillAbilityTag = App.SkillAbilityTag.build()
      assert.equal urlFor(skillAbilityTag, action: 'new'), "/skillAbilityTags/new"

    test 'show', ->
      skillAbilityTag = new App.SkillAbilityTag(id: 1)
      assert.equal urlFor(skillAbilityTag), "/skillAbilityTags/#{skillAbilityTag.get('id')}"

    test 'edit', ->
      skillAbilityTag = new App.SkillAbilityTag(id: 1)
      assert.equal urlFor(skillAbilityTag, action: 'edit'), "/skillAbilityTags/#{skillAbilityTag.get('id')}/edit"

  describe '#index', ->
    beforeEach (done) ->
      factory 'skillAbilityTag', (error, record) =>
        skillAbilityTag = record
        done()

    test 'render json', (done) ->
      get urlFor(App.SkillAbilityTag), format: "json", (request) ->
        assert.equal @headers["Content-Type"], 'application/json'

        done()

  describe '#new', ->

  describe '#create', ->
    beforeEach ->
      url = urlFor(App.SkillAbilityTag)

    test 'params', (done) ->
      params = {}

      post url, format: "json", params: params, (response) ->
        App.SkillAbilityTag.count (error, count) =>
          assert.equal count, 1
          done()

  describe "#show", ->

  describe "#edit", ->

  describe "#update", ->

  describe "#destroy", ->
###