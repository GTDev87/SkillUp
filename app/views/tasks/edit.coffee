@title = "Editing Task"

partial "form"

contentFor "sidebar", ->
  header class: "widget header", ->
    h2 @task.toLabel()