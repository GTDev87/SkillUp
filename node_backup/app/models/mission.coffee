class App.Mission extends Tower.Model
  @field 'title', type: 'String'
  @field 'description', type: 'String'
  
  @hasMany 'aptitudes', as: 'aptitudeable', embed: true

  @belongsTo 'task'
  
  @validates 'title', presence: true
  
  @timestamps()