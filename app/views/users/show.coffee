@title = "User"

text '{{#with resource}}'
dl class: "content", ->
  dt "Email:"
  dd '{{email}}'
  dt "First name:"
  dd '{{firstName}}'
  dt "Last name:"
  dd '{{lastName}}'
text '{{/with}}'