# Tower.debug = Tower.env == 'development'

App.bootstrap = (data) ->
  App.SkillAbilityTag.load(data.skillAbilityTags) if data.skillAbilityTags
  App.Mission.load(data.missions) if data.missions
  App.Ability.load(data.abilities) if data.abilities
  App.Skill.load(data.skills) if data.skills
  App.Aptitude.load(data.aptitudes) if data.aptitudes
  App.Task.load(data.tasks) if data.tasks
  App.User.load(data.users) if data.users
  # Optimized rendering (force right at bottom of DOM, before DOM ready)
  Ember.Handlebars.bootstrap(Ember.$(document))

  Tower.NetConnection.transport = Tower.StoreTransportAjax
  if Tower.env == 'development'
    Tower.StoreTransportAjax.defaults.async = false
    
  App.initialize()
  App.listen()

  # Force rendering before dom ready (better UX with ember)
  Ember.run.autorun()
  Ember.run.currentRunLoop.flush('render')
