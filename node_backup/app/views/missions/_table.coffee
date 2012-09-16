
tableFor 'missions', (t) ->
  t.head ->
    t.row ->
      t.header 'title', sort: true
      t.header 'description', sort: true
  t.body ->
    text '{{#each mission in App.missionsController.all}}'
    t.row class: 'mission', ->
      t.cell '{{mission.title}}'
      t.cell '{{mission.description}}'
      t.cell ->
        a '{{action showMission mission href=true}}', 'Show'
        span '|'
        a '{{action editMission mission href=true}}', 'Edit'
        span '|'
        a '{{action destroyMission mission}}', 'Destroy'
    text '{{/each}}'
  t.foot ->
    t.row ->
      t.cell colspan: 5, ->
        a '{{action newMission mission href=true}}', 'New Mission'

