li class: "aptitude", ->
  header class: "header", ->
    h3 @aptitude.toLabel()
  dl class: "content", ->
    dt "Level:"
    dd @aptitude.get("level")
  footer class: "footer", ->
    menu ->
      menuItem "Edit", urlFor(@aptitude, action: "edit")
