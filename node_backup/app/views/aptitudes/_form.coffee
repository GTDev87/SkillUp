text '{{#with resource}}'
form ->
  fieldset ->
    ul class: 'fields', ->
      li class: 'control-group', ->
        div class: 'controls', ->
          label 'Level:'
          text '{{view Ember.TextField valueBinding="level"}}'
          text '{{#with errors}}'
          span class: 'help-inline error', '{{level}}'
          text '{{/with}}'
      li ->
        a '{{action submit target="resource"}}', 'Submit'
text '{{/with}}'
