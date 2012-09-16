class App.AbilitiesController extends App.ApplicationController
  @param 'title'
  @param 'description'
###
  index: ->
    App.Ability.where(@criteria()).all (error, collection) =>
      @render "index"

  new: ->
    resource = new App.Ability
    @render "new"

  create: ->
    App.Ability.create @params.ability, (error, resource) =>
      if error
        @redirectTo "new"
      else
        @redirectTo @urlFor(resource)

  show:  ->
    App.Ability.find @params.id, (error, resource) =>
      if resource
        @render "show"
      else
        @redirectTo "index"

  edit: ->
    App.Ability.find @params.id, (error, resource) =>
      if resource
        @render "edit"
      else
        @redirectTo "index"

  update: ->
    App.Ability.find @params.id (error, resource) =>
      if error
        @redirectTo "edit"
      else
        resource.updateAttributes @params.ability, (error) =>
          @redirectTo @urlFor(resource)

  destroy: ->
    App.Ability.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"

###
