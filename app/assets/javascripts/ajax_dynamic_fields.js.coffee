jQuery ->  
  $( document ).on "click", ".ajax_remove_field", (event) ->
    $(this).closest('fieldset').remove()
    event.preventDefault()

