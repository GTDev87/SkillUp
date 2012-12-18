# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

#defining slider
jQuery ->
  $('#related_slider').slider({
    value: 1,
    min: 1,
    max: 10,
    step: 1,
    slide: ( event, ui ) ->
      level = ui.value

      #this is setting the ammount field
      $( "#amount" ).val( "Level " + level + " Skills" )

      $.ajax({
        type: "GET",
        data: { level_mission: level },
        url: $('#products').data('url'),
        dataType: 'script'
      })

  })
  #this is setting the ammount field
  $( "#amount" ).val( "Level " + $( "#related_slider" ).slider( "value" ) + " Skills");
  
  