class App.Ability extends Tower.Model
  @field 'title', type: 'String'
  @field 'description', type: 'String'

  @hasMany 'SkillAbilityTag'

  @timestamps()
