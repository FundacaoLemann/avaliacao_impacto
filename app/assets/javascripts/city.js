var cityName = "";
var city = "";

$(function() {
  $("#city").on('change', function() {
    cityName = $("#city option:selected").text();
    city = $("#city").val();
  });
});

$(function() {
  $("#city").on('focus', function() {
    $('#administration').removeAttr('disabled');
  });
});
