
tableFor 'skills', (t) ->
  t.head ->
    t.row ->
      t.header 'description', sort: true
      t.header 'title', sort: true
  t.body ->
    text '{{#each skill in App.skillsController.all}}'
    t.row class: 'skill', ->
      t.cell '{{skill.description}}'
      t.cell '{{skill.title}}'
      t.cell ->
        a '{{action showSkill skill href=true}}', 'Show'
        span '|'
        a '{{action editSkill skill href=true}}', 'Edit'
        span '|'
        a '{{action destroySkill skill}}', 'Destroy'
    text '{{/each}}'
  t.foot ->
    t.row ->
      t.cell colspan: 5, ->
        a '{{action newSkill skill href=true}}', 'New Skill'

