class App.SkillsController extends App.ApplicationController
  @param 'description'
  @param 'title'
###
  index: ->
    App.Skill.where(@criteria()).all (error, collection) =>
      @render "index"

  new: ->
    resource = new App.Skill
    @render "new"

  create: ->
    App.Skill.create @params.skill, (error, resource) =>
      if error
        @redirectTo "new"
      else
        @redirectTo @urlFor(resource)

  show:  ->
    App.Skill.find @params.id, (error, resource) =>
      if resource
        @render "show"
      else
        @redirectTo "index"

  edit: ->
    App.Skill.find @params.id, (error, resource) =>
      if resource
        @render "edit"
      else
        @redirectTo "index"

  update: ->
    App.Skill.find @params.id (error, resource) =>
      if error
        @redirectTo "edit"
      else
        resource.updateAttributes @params.skill, (error) =>
          @redirectTo @urlFor(resource)

  destroy: ->
    App.Skill.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"

###
