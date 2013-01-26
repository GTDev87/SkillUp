#$ ->
#  checkedId = $(".rating_ballot > input:checked").attr("id")
#  $(".rating_ballot > label[for=" + checkedId + "]").prevAll().andSelf().addClass "bright"

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
  
  # Submits the form (saves data) after user makes a change.
  #$(".rating_ballot").live
  #  change: ->
  #    $(".rating_ballot").submit()

