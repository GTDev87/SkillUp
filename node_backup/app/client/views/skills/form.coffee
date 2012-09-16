App.SkillsEditView = Ember.View.extend
  templateName: 'skills/edit'
  resourceBinding: 'controller.resource'
  # You can also use an object controller (Ember.ObjectProxy) 
  # as a layer between the view and the model if you'd like more control.
  # resourceControllerBinding: 'controller.resourceController'
  
  submit: (event) ->
    # @todo
    # if @get('resource.isNew')
    #   @get('controller.target').send('createSkill')
    # else
    #   @get('controller.target').send('updateSkill', @get('resource'))
    @get('resource').save()
    Tower.router.transitionTo('skills.index')
    return false
