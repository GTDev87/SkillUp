a '{{action showRoot href=true}}', class: 'brand', -> t('title')

div class: 'nav-collapse', ->
  ul class: 'nav', ->
    li ->
      a '{{action indexSkillAbilityTag href=true}}', t('links.skillAbilityTags')
    li ->
      a '{{action indexMission href=true}}', t('links.missions')
    li ->
      a '{{action indexAbility href=true}}', t('links.abilities')
    li ->
      a '{{action indexSkill href=true}}', t('links.skills')
    li ->
      a '{{action indexAptitude href=true}}', t('links.aptitudes')
    li ->
      a '{{action indexTask href=true}}', t('links.tasks')
    li ->
      a '{{action indexUser href=true}}', t('links.users')
  ul class: 'nav pull-right', ->
    li class: 'dropdown', ->
      linkTo t('links.docs'), '#', class: 'dropdown-toggle', 'data-toggle': 'dropdown', ->
        b class: 'caret'
      ul class: 'dropdown-menu', ->
        li ->
          linkTo 'Tower.js', 'http://towerjs.org'
