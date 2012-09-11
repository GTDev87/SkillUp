class App.Task extends Tower.Model
  @field 'title', type: 'String'
  @field 'description', type: 'String'

  @belongsTo 'user'

  @timestamps()
