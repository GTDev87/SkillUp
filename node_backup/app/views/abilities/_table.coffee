
tableFor 'abilities', (t) ->
  t.head ->
    t.row ->
      t.header 'title', sort: true
      t.header 'description', sort: true
  t.body ->
    text '{{#each ability in App.abilitiesController.all}}'
    t.row class: 'ability', ->
      t.cell '{{ability.title}}'
      t.cell '{{ability.description}}'
      t.cell ->
        a '{{action showAbility ability href=true}}', 'Show'
        span '|'
        a '{{action editAbility ability href=true}}', 'Edit'
        span '|'
        a '{{action destroyAbility ability}}', 'Destroy'
    text '{{/each}}'
  t.foot ->
    t.row ->
      t.cell colspan: 5, ->
        a '{{action newAbility ability href=true}}', 'New Ability'

