class App.Mission extends Tower.Model
  @field 'title', type: 'String'
  @field 'description', type: 'String'

  @belongsTo 'task'
  
  @hasMany 'aptitudes', as: 'aptitudeable', embed: true

  @timestamps()
