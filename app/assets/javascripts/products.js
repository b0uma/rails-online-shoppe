// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  $('#cart-button').on("ajax:success", function(event, response) {
    $(this).append(response);
  });
});
