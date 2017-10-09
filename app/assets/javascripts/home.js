// get cities by state
var state = ""
$(function() {
  $("[name='state_id']").on('change', function() {
    state = $("[name='state_id']").val();
    $.ajax({
      url: '/state/' + state,
      method: 'GET'
    });
  });
});

// set city
var city = "";
$(function() {
  $("[name='city_name']").on('change', function() {
    city = $("[name='city_name']").val();
  });
});

// set administration
var administration = "";
$(function() {
  $("[name='administration']").on('change', function() {
    administration = $("[name='administration']").val();
  });
});

// set school
document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='search']")
  var options = {
    getValue: 'name',
    url: function(phrase) {
      return ('/search.json?state=' + state + '&city=' + city + 
      '&administration=' + administration + '&school=' + phrase);
    },
    listLocation: 'mec_schools'
  }
  $input.easyAutocomplete(options)
});

// prefill form assembly
$(function() {
  $("input[type=submit]").on('click', function(e) {
    e.preventDefault();
    var url = $("[name='form_assembly_url']").val();
    var tfa_2 = "tfa_2=" + $("[name='name']").val();
    var tfa_3 = "&tfa_3=" + $("[name='email']").val();
    var inep = $("[name='inep']").val();
    var school = $("[name='school']").val();
    window.open(url + tfa_2 + tfa_3)
  });
});
