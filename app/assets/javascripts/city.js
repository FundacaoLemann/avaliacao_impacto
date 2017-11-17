var cityName = "";

$(function() {
  $("#city").on('blur', function() {
    cityName = $("#city option:selected").text();
    $('#administration').removeAttr('disabled');
  });
});
