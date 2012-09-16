li class: "skill", ->
  header class: "header", ->
    h3 @skill.toLabel()
  dl class: "content", ->
    dt "Description:"
    dd @skill.get("description")
    dt "Title:"
    dd @skill.get("title")
  footer class: "footer", ->
    menu ->
      menuItem "Edit", urlFor(@skill, action: "edit")
