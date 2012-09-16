text '{{#with resource}}'
form ->
  fieldset ->
    ul class: 'fields', ->
      li class: 'control-group', ->
        div class: 'controls', ->
          label 'Email:'
          text '{{view Ember.TextField valueBinding="email"}}'
          text '{{#with errors}}'
          span class: 'help-inline error', '{{email}}'
          text '{{/with}}'
      li class: 'control-group', ->
        div class: 'controls', ->
          label 'First name:'
          text '{{view Ember.TextField valueBinding="firstName"}}'
          text '{{#with errors}}'
          span class: 'help-inline error', '{{firstName}}'
          text '{{/with}}'
      li class: 'control-group', ->
        div class: 'controls', ->
          label 'Last name:'
          text '{{view Ember.TextField valueBinding="lastName"}}'
          text '{{#with errors}}'
          span class: 'help-inline error', '{{lastName}}'
          text '{{/with}}'
      li ->
        a '{{action submit target="resource"}}', 'Submit'
text '{{/with}}'
