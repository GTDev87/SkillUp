class App.Task extends Tower.Model
  @hasOne 'mission'
  
  @belongsTo 'user', embed: true

  @timestamps()