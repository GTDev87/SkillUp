@title = "Editing SkillAbilityTag"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @skillAbilityTag.toLabel()