@title = "Editing Aptitude"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @aptitude.toLabel()