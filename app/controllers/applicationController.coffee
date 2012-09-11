class App.ApplicationController extends Tower.Controller
  @layout 'application'
  
  @param 'page', type: 'Number', allowRange: false, allowNegative: false
  @param 'limit', type: 'Number', allowRange: false, allowNegative: false
  @param 'createdAt', type: 'Date'
  @param 'updatedAt', type: 'Date'

  @beforeAction 'bootstrap'#, only: 'welcome'

  welcome: ->
    @render 'welcome', locals: {@bootstrapData}

  # Example of how you might bootstrap a one-page application.
  bootstrap: (callback) ->
    data = @bootstrapData = {}

    # for every model you add, you can add it to the bootstrap
    # dataset by using this async helper.
    _.series [
      (next) => App.Task.all (error, tasks) =>
        data.tasks = tasks
        next()
      (next) => App.User.all (error, users) =>
        data.users = users
        next()
    ], callback