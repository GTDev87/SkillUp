class App.AptitudesController extends App.ApplicationController
  @param 'baseLevel'
###
  index: ->
    App.Aptitude.where(@criteria()).all (error, collection) =>
      @render "index"

  new: ->
    resource = new App.Aptitude
    @render "new"

  create: ->
    App.Aptitude.create @params.aptitude, (error, resource) =>
      if error
        @redirectTo "new"
      else
        @redirectTo @urlFor(resource)

  show:  ->
    App.Aptitude.find @params.id, (error, resource) =>
      if resource
        @render "show"
      else
        @redirectTo "index"

  edit: ->
    App.Aptitude.find @params.id, (error, resource) =>
      if resource
        @render "edit"
      else
        @redirectTo "index"

  update: ->
    App.Aptitude.find @params.id (error, resource) =>
      if error
        @redirectTo "edit"
      else
        resource.updateAttributes @params.aptitude, (error) =>
          @redirectTo @urlFor(resource)

  destroy: ->
    App.Aptitude.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"

###
