class App.Aptitude extends Tower.Model
  @field 'baseLevel', type: 'Int'
  
  @belongsTo 'aptitudeable', polymorphic: true, embed: true
  
  @hasOne 'skill'

  @timestamps()
