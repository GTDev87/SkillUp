
tableFor 'aptitudes', (t) ->
  t.head ->
    t.row ->
      t.header 'level', sort: true
  t.body ->
    text '{{#each aptitude in App.aptitudesController.all}}'
    t.row class: 'aptitude', ->
      t.cell '{{aptitude.level}}'
      t.cell ->
        a '{{action showAptitude aptitude href=true}}', 'Show'
        span '|'
        a '{{action editAptitude aptitude href=true}}', 'Edit'
        span '|'
        a '{{action destroyAptitude aptitude}}', 'Destroy'
    text '{{/each}}'
  t.foot ->
    t.row ->
      t.cell colspan: 4, ->
        a '{{action newAptitude aptitude href=true}}', 'New Aptitude'

