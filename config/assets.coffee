module.exports =
  javascripts:
    application: [
      '/config/application'
      # "/config/environments/#{Tower.env}"
      '/app/client/config/bootstrap'
      '/config/routes'
      '/app/client/controllers/applicationController'
      '/templates'
      '/app/client/views/layouts/application'
      '/app/models/user'
      '/app/client/views/users/form'
      '/app/client/views/users/index'
      '/app/client/views/users/show'
      '/app/client/controllers/usersController'
      '/app/models/task'
      '/app/client/views/tasks/form'
      '/app/client/views/tasks/index'
      '/app/client/views/tasks/show'
      '/app/client/controllers/tasksController'
      '/app/models/aptitude'
      '/app/client/views/aptitudes/form'
      '/app/client/views/aptitudes/index'
      '/app/client/views/aptitudes/show'
      '/app/client/controllers/aptitudesController'
      '/app/models/skill'
      '/app/client/views/skills/form'
      '/app/client/views/skills/index'
      '/app/client/views/skills/show'
      '/app/client/controllers/skillsController'
    ]

    lib: [

    ]

    vendor: [
      '/vendor/javascripts/underscore'
      '/vendor/javascripts/underscore.string'
      '/vendor/javascripts/moment'
      '/vendor/javascripts/geolib'
      '/vendor/javascripts/validator'
      '/vendor/javascripts/accounting'
      '/vendor/javascripts/inflection'
      '/vendor/javascripts/async'
      '/vendor/javascripts/socket.io'
      '/vendor/javascripts/handlebars'
      '/vendor/javascripts/ember'
      '/vendor/javascripts/tower'
      # '/vendor/javascripts/uri'
      # '/vendor/javascripts/bootstrap/bootstrap-transition'
      # '/vendor/javascripts/bootstrap/bootstrap-alert'
      # '/vendor/javascripts/bootstrap/bootstrap-modal'
      '/vendor/javascripts/bootstrap/bootstrap-dropdown'
      # '/vendor/javascripts/bootstrap/bootstrap-scrollspy'
      # '/vendor/javascripts/bootstrap/bootstrap-tab'
      # '/vendor/javascripts/bootstrap/bootstrap-tooltip'
      # '/vendor/javascripts/bootstrap/bootstrap-popover'
      # '/vendor/javascripts/bootstrap/bootstrap-button'
      # '/vendor/javascripts/bootstrap/bootstrap-collapse'
      # '/vendor/javascripts/bootstrap/bootstrap-carousel'
      # '/vendor/javascripts/bootstrap/bootstrap-typeahead'
      # '/vendor/javascripts/prettify'
    ]

    development: [
      '/vendor/javascripts/mocha'
      '/vendor/javascripts/chai'
      '/test/client'
      '/test/models/userTest'
      '/test/models/taskTest'
      '/test/models/aptitudeTest'
      '/test/models/skillTest'
    ]

  stylesheets:
    application: [
      '/app/client/stylesheets/application'
    ]

    lib: [

    ]

    vendor: [
      '/vendor/stylesheets/bootstrap/bootstrap'
      '/vendor/stylesheets/prettify'
    ]

    development: [
      # '/vendor/stylesheets/mocha'
    ]
