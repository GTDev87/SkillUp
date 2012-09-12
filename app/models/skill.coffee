class App.Skill extends Tower.Model
  @field 'description', type: 'String'
  @field 'title', type: 'String'

  @belongsTo 'aptitude'
  @hasMany 'SkillAbilityTags'

  @timestamps()
