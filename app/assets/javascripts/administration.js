// set administration and update section fields
var administration = "";
var faParams = "";
var deadline = "";
var stateUrl = "";
var cityUrl = "";

$(function() {
  $("#administration").on('change', function() {
    administration = $("#administration").val();
    $('#school').removeAttr('disabled');
    deadline = "";
    faParams = "";
    getFormOption(administration);
  });
});

// get form assembly params and deadline from admin route
function getFormOption(adm){
  adminUrl = adm == 'Municipal' ? getCityUrl() : getStateUrl();
  $.ajax({
    url: adminUrl,
    method: 'GET',
    success: function(data){
      if(data[0]){
        deadline = data[0].deadline;
        faParams = data[0].form_assembly_params;
      }
    }
  });
}

// get state url based on the current route
function getStateUrl(){
  var stateUrl = '/admin/form_options.json?' +
                 'q%5Bform_name%5D=baseline' +
                 '&q%5Bstate_or_city_equals%5D=' + stateName +
                 '&q%5Bdependencia_desc_equals%5D=Estadual';
  if ($(".home.follow_up").length > 0) {
    stateUrl = '/admin/form_options.json?' +
               'q%5Bform_name%5D=follow_up' +
               '&q%5Bstate_or_city_equals%5D=' + stateName +
               '&q%5Bdependencia_desc_equals%5D=Estadual';
  }
  return stateUrl;
}

// get city url based on the current route
function getCityUrl(){
  var cityUrl = '/admin/form_options.json?' +
                'q%5Bform_name%5D=baseline' +
                '&q%5Bstate_or_city_equals%5D=' + cityName +
                '&q%5Bdependencia_desc_equals%5D=Municipal';
  if ($(".home.follow_up").length > 0) {
    cityUrl = '/admin/form_options.json?' +
              'q%5Bform_name%5D=baseline' +
              '&q%5Bstate_or_city_equals%5D=' + cityName +
              '&q%5Bdependencia_desc_equals%5D=Municipal';
  }
  return cityUrl;
}
