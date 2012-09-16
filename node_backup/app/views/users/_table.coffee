
tableFor 'users', (t) ->
  t.head ->
    t.row ->
      t.header 'email', sort: true
      t.header 'firstName', sort: true
      t.header 'lastName', sort: true
  t.body ->
    text '{{#each user in App.usersController.all}}'
    t.row class: 'user', ->
      t.cell '{{user.email}}'
      t.cell '{{user.firstName}}'
      t.cell '{{user.lastName}}'
      t.cell ->
        a '{{action showUser user href=true}}', 'Show'
        span '|'
        a '{{action editUser user href=true}}', 'Edit'
        span '|'
        a '{{action destroyUser user}}', 'Destroy'
    text '{{/each}}'
  t.foot ->
    t.row ->
      t.cell colspan: 6, ->
        a '{{action newUser user href=true}}', 'New User'

