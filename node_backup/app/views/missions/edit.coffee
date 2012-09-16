@title = "Editing Mission"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @mission.toLabel()