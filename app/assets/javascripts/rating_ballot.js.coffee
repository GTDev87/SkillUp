$(document).ready ->
  $(document).on 'mouseenter', '.rating_ballot > label.rating', ->
    $(this).prevAll().andSelf().addClass "glow"
  $(document).on 'mouseleave', '.rating_ballot > label.rating', ->
    $(this).siblings().andSelf().removeClass "glow"
  
  # Makes stars stay glowing after click.
  $(document).on 'click', '.rating_ballot > label.rating', ->
    $(this).siblings().removeClass "bright"
    $(this).prevAll().andSelf().addClass "bright"

