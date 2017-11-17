var state = "";
var stateName = "";
var cityName = "";

$(function() {
  $("#state").on('change', function() {
    state = $("#state").val();
    stateName = $("#state option:selected").text();
    $.ajax({
      url: '/state/' + state,
      method: 'GET'
    });
    $('#city').removeAttr('disabled');

    setTimeout(function(){
      cityName = $("#city option:selected").text();
    }, 500);
  });
});
