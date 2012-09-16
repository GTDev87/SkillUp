Tower.Route.draw ->
  @resources "skill-ability-tags"
  @resources "missions"
  @resources "abilities"
  @resources "skills"
  @resources "aptitudes"
  @resources "tasks"
  @resources "users"
  # @match '(/*path)', to: 'application#index'
  @match '/', to: 'application#welcome'
