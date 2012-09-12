class App.User extends Tower.Model
  @field 'email', type: 'String'
  
  @field 'username', type: 'String'

  @hasMany 'aptitudes', as: 'aptitudeable', embed: true
  @hasMany 'tasks', embed: true

  @timestamps()
