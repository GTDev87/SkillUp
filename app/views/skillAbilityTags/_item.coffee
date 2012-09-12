li class: "skill-ability-tag", ->
  header class: "header", ->
    h3 @skillAbilityTag.toLabel()
  dl class: "content", ->
  footer class: "footer", ->
    menu ->
      menuItem "Edit", urlFor(@skillAbilityTag, action: "edit")
