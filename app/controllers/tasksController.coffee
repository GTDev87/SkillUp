class App.TasksController extends App.ApplicationController
  @param 'title'
  @param 'description'
###
  index: ->
    App.Task.where(@criteria()).all (error, collection) =>
      @render "index"

  new: ->
    resource = new App.Task
    @render "new"

  create: ->
    App.Task.create @params.task, (error, resource) =>
      if error
        @redirectTo "new"
      else
        @redirectTo @urlFor(resource)

  show:  ->
    App.Task.find @params.id, (error, resource) =>
      if resource
        @render "show"
      else
        @redirectTo "index"

  edit: ->
    App.Task.find @params.id, (error, resource) =>
      if resource
        @render "edit"
      else
        @redirectTo "index"

  update: ->
    App.Task.find @params.id (error, resource) =>
      if error
        @redirectTo "edit"
      else
        resource.updateAttributes @params.task, (error) =>
          @redirectTo @urlFor(resource)

  destroy: ->
    App.Task.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"

###
