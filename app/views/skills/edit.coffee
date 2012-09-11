@title = "Editing Skill"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @skill.toLabel()