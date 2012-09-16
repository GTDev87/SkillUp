@title = "Aptitude"

text '{{#with resource}}'
dl class: "content", ->
  dt "Level:"
  dd '{{level}}'
text '{{/with}}'