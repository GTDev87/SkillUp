@title = "Editing Ability"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @ability.toLabel()