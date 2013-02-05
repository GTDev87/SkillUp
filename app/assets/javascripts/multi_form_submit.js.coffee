jQuery ->

  $(document).ready -> 
    $('.multiSubmitButton').hide(); 

  $( document ).on "click", ".multiSubmitButton", (event) ->
    $(this).closest("multiform").find("form").each (i, item) ->
      $(item).trigger "submit.rails"