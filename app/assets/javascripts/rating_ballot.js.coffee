$(document).ready ->
  
  $(".rating_ballot > label.rating").live
    mouseenter: ->
      $(this).prevAll().andSelf().addClass "glow"
    mouseleave: ->
      $(this).siblings().andSelf().removeClass "glow"
  
  # Makes stars stay glowing after click.
  $(".rating_ballot > label.rating").live
    click: ->
      $(this).siblings().removeClass "bright"
      $(this).prevAll().andSelf().addClass "bright"

