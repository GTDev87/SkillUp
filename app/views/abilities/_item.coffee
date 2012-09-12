li class: "ability", ->
  header class: "header", ->
    h3 @ability.toLabel()
  dl class: "content", ->
    dt "Title:"
    dd @ability.get("title")
    dt "Description:"
    dd @ability.get("description")
  footer class: "footer", ->
    menu ->
      menuItem "Edit", urlFor(@ability, action: "edit")
