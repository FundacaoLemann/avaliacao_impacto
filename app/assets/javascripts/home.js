// get cities by state
var state = "";
var state_name = "";
$(function() {
  $("#state").on('change', function() {
    state = $("#state").val();
    state_name = $("#state option:selected").text();
    $.ajax({
      url: '/state/' + state,
      method: 'GET'
    });
  });
});

// set city
var city = "";
$(function() {
  $("#city").on('change', function() {
    city = $("#city").val();
  });
});

// set administration and update section fields
var administration = "";
var form_assembly_params = "";
$(function() {
  $("#administration").on('change', function() {
    administration = $("#administration").val();
    if(administration == 'Estadual'){
      $.ajax({
        url: '/admin/form_options.json?q%5Bstate_or_city_equals%5D=' + state_name + '&q%5Bdependencia_desc_equals%5D=' + administration,
        method: 'GET',
        success: function(data){
          form_assembly_params = data[0].form_assembly_params;
        }
      });
    }
    else{
      $.ajax({
        url: '/admin/form_options.json?q%5Bstate_or_city_equals%5D=' + city + '&q%5Bdependencia_desc_equals%5D=' + administration,
        method: 'GET',
        success: function(data){
          form_assembly_params = data[0].form_assembly_params;
        }
      });
    }
  });
});

// set school
document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='search']");
  var options = {
    getValue: 'name',
    url: function(phrase) {
      return ('/search.json?state=' + state + '&city=' + city + 
      '&administration=' + administration + '&school=' + phrase);
    },
    listLocation: 'schools'
  };

  $input.easyAutocomplete(options);
});

// prefill form assembly
$(function() {
  $("input[type=submit]").on('click', function(e) {
    e.preventDefault();
    url = $("#form_assembly_url").val();
    // split id, inep and name from school
    id_inep_name = $("#school").val().split(' - ');
    
    // prefill id
    tfa_3707 = "&tfa_3707=" + id_inep_name[0];
    // prefill inep
    tfa_5 = "&tfa_5=" + id_inep_name[1];
    // prefill school name
    tfa_7 = "&tfa_7=" + id_inep_name[2];
    // prefill person name
    tfa_112 = "&tfa_112=" + $("#name").val();
    // prefill person email
    tfa_80 = "&tfa_80=" + $("#email").val();
    // prefill school phone
    tfa_84 = "&tfa_84=" + $("#phone").val();
    // prefill personal phone
    tfa_86 = "&tfa_86=" + $("#personal_phone").val();
    
    if(!form_assembly_params){
      form_assembly_params = "tfa_63=1&tfa_64=1&tfa_65=1&tfa_66=1&tfa_2567=1&tfa_2568=1&";
    }
    window.open(url + form_assembly_params + tfa_3707 + tfa_7 + tfa_5 + tfa_112 + tfa_80 + tfa_84 + tfa_86);
  });
});
