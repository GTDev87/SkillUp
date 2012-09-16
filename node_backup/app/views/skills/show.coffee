@title = "Skill"

text '{{#with resource}}'
dl class: "content", ->
  dt "Description:"
  dd '{{description}}'
  dt "Title:"
  dd '{{title}}'
text '{{/with}}'