$(function() {
  $("#city").on('focus', function() {
    $('#administration').removeAttr('disabled');
  });
});
