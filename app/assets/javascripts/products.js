// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.

$(document).ready(function() {
  var productId = window.location.pathname.split('/')[2];
  $('#cart-button').on("ajax:success", function(event, response) {
    // remove the cart if it's already there
    if ($('#cart').length != 0) {
      $('#cart').remove();
    }
    $('.container').append(response);
    // prevent adding items to the cart if you've already exceeded the stock
    if ($('#quantity-' + productId).text() === $('#product-quantity').text()) {
      $(this).attr('disabled', 'disabled');
    }
  });
});
