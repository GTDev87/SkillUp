@title = "Mission"

text '{{#with resource}}'
dl class: "content", ->
  dt "Title:"
  dd '{{title}}'
  dt "Description:"
  dd '{{description}}'
text '{{/with}}'