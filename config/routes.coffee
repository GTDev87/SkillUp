Tower.Route.draw ->
  @resources "skills"
  @resources "aptitudes"
  @resources "tasks"
  @resources "users"
  # @match '(/*path)', to: 'application#index'
  @match '/', to: 'application#welcome'
