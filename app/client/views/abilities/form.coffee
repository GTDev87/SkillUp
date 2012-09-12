App.AbilitiesEditView = Ember.View.extend
  templateName: 'abilities/edit'
  resourceBinding: 'controller.resource'
  # You can also use an object controller (Ember.ObjectProxy) 
  # as a layer between the view and the model if you'd like more control.
  # resourceControllerBinding: 'controller.resourceController'
  
  submit: (event) ->
    # @todo
    # if @get('resource.isNew')
    #   @get('controller.target').send('createAbility')
    # else
    #   @get('controller.target').send('updateAbility', @get('resource'))
    @get('resource').save()
    Tower.router.transitionTo('abilities.index')
    return false
