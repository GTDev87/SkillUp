class App.SkillAbilityTag extends Tower.Model
  @belongsTo 'skill'
  @belongsTo 'ability'

  @timestamps()