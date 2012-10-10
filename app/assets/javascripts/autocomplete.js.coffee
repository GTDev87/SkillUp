# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
jQuery ->
  $('fieldset').live 'click', ->
    $('.autocomplete_field1').autocomplete
      source: $('.autocomplete_field1').data('autocomplete-source')
    $('.autocomplete_field2').autocomplete
      source: $('.autocomplete_field2').data('autocomplete-source')