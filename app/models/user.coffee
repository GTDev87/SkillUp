class App.User extends Tower.Model
  @field 'email', type: 'String'
  @field 'firstName', type: 'String'
  @field 'lastName', type: 'String'

  @hasMany 'aptitudes', as: 'aptitudeable', embed: true
  @hasMany 'tasks', embed: true

  @timestamps()
