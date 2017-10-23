// get cities by state
var state = "";
$(function() {
  $("#state").on('change', function() {
    state = $("#state").val();
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

// set administration
var administration = "";
$(function() {
  $("#administration").on('change', function() {
    administration = $("#administration").val();
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
    id_inep_name = $("#school").val().split(' - ');

    tfa_2 = "tfa_2=" + $("#name").val();
    tfa_3 = "&tfa_3=" + $("#email").val();
    tfa_5 = "&tfa_5=" + id_inep_name[2];
    tfa_6 = "&tfa_6=" + id_inep_name[0];
    tfa_7 = "&tfa_7=" + id_inep_name[1];

    window.open(url + tfa_2 + tfa_3 + tfa_5 + tfa_6 + tfa_7);
  });
});
