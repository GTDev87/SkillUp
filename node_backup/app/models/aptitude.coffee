class App.Aptitude extends Tower.Model
  @field 'level', type: 'Number'
  
  @hasOne 'skill'
  
  @belongsTo 'aptitudeable', polymorphic: true, embed: true
  
  @timestamps()