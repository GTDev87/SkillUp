class App.Skill extends Tower.Model
  @field 'title', type: 'String'
  @field 'description', type: 'String'

  @hasMany 'SkillAbilityTags'
  
  @belongsTo 'aptitude'
  
  @validates 'title', presence: true

  @timestamps()