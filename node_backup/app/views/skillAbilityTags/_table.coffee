
tableFor 'skillAbilityTags', (t) ->
  t.head ->
    t.row ->
  t.body ->
    text '{{#each skillAbilityTag in App.skillAbilityTagsController.all}}'
    t.row class: 'skillAbilityTag', ->
      t.cell ->
        a '{{action showSkillAbilityTag skillAbilityTag href=true}}', 'Show'
        span '|'
        a '{{action editSkillAbilityTag skillAbilityTag href=true}}', 'Edit'
        span '|'
        a '{{action destroySkillAbilityTag skillAbilityTag}}', 'Destroy'
    text '{{/each}}'
  t.foot ->
    t.row ->
      t.cell colspan: 3, ->
        a '{{action newSkillAbilityTag skillAbilityTag href=true}}', 'New Skill ability tag'

