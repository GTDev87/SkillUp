class App.SkillAbilityTagsController extends App.ApplicationController
###
  index: ->
    App.SkillAbilityTag.where(@criteria()).all (error, collection) =>
      @render "index"

  new: ->
    resource = new App.SkillAbilityTag
    @render "new"

  create: ->
    App.SkillAbilityTag.create @params.skillAbilityTag, (error, resource) =>
      if error
        @redirectTo "new"
      else
        @redirectTo @urlFor(resource)

  show:  ->
    App.SkillAbilityTag.find @params.id, (error, resource) =>
      if resource
        @render "show"
      else
        @redirectTo "index"

  edit: ->
    App.SkillAbilityTag.find @params.id, (error, resource) =>
      if resource
        @render "edit"
      else
        @redirectTo "index"

  update: ->
    App.SkillAbilityTag.find @params.id (error, resource) =>
      if error
        @redirectTo "edit"
      else
        resource.updateAttributes @params.skillAbilityTag, (error) =>
          @redirectTo @urlFor(resource)

  destroy: ->
    App.SkillAbilityTag.find @params.id, (error, resource) =>
      if error
        @redirectTo "index"
      else
        resource.destroy (error) =>
          @redirectTo "index"

###
