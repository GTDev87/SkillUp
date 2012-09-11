Tower.Route.draw ->
  @resources "tasks"
  @resources "users"
  # @match '(/*path)', to: 'application#index'
  @match '/', to: 'application#welcome'
