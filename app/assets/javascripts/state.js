var state = "";
var stateName = "";

$(function() {
  $("#state").on('change', function() {
    state = parseInt($("#state").val());
    stateName = $("#state option:selected").text();
    $.ajax({
      url: '/state/' + state,
      method: 'GET'
    });
    $('#city').removeAttr('disabled');
  });
});
