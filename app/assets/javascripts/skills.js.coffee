# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#defining slider
jQuery ->
  slider_data = $('#slider').data('slider')
  slider_val = if slider_data["value_id"] then slider_data["value_id"] else "value"
  slider_data.slide = (event, ui) ->
    $("#"+slider_val).val("$" + ui.value)
  $('#slider').slider(slider_data)
  