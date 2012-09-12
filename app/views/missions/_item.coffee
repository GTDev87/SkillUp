li class: "mission", ->
  header class: "header", ->
    h3 @mission.toLabel()
  dl class: "content", ->
    dt "Title:"
    dd @mission.get("title")
    dt "Description:"
    dd @mission.get("description")
  footer class: "footer", ->
    menu ->
      menuItem "Edit", urlFor(@mission, action: "edit")
