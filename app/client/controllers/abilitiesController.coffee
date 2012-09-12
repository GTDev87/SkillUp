class App.AbilitiesController extends Tower.Controller
  @scope 'all'

  # @todo refactor
  destroy: ->
    @get('resource').destroy()
