class App.Aptitude extends Tower.Model
  @field 'baseLevel', type: 'Int'

  @belongsTo 'user'
  @hasOne 'skill'

  @timestamps()
