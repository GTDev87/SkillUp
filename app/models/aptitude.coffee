class App.Aptitude extends Tower.Model
  @field 'level', type: 'Number'
  
  @belongsTo 'aptitudeable', polymorphic: true, embed: true
  
  @hasOne 'skill'

  @timestamps()
