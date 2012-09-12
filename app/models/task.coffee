class App.Task extends Tower.Model
  @belongsTo 'user', embed: true
  
  @hasOne 'mission'

  @timestamps()
