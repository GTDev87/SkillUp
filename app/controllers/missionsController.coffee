class App.MissionsController extends App.ApplicationController
  @param 'title'
  @param 'description'
###
  index: ->
    App.Mission.where(@criteria()).all (error, collection) =>
      @render "index"

  new: ->
    resource = new App.Mission
    @render "new"

  create: ->
    App.Mission.create @params.mission, (error, resource) =>
      if error
        @redirectTo "new"
      else
        @redirectTo @urlFor(resource)

  show:  ->
    App.Mission.find @params.id, (error, resource) =>
      if resource
        @render "show"
      else
        @redirectTo "index"

  edit: ->
    App.Mission.find @params.id, (error, resource) =>
      if resource
        @render "edit"
      else
        @redirectTo "index"

  update: ->
    App.Mission.find @params.id (error, resource) =>
      if error
        @redirectTo "edit"
      else
        resource.updateAttributes @params.mission, (error) =>
          @redirectTo @urlFor(resource)

  destroy: ->
    App.Mission.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"

###
