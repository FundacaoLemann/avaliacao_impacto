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
    $('#city').removeAttr('disabled');
    if(state == 7){ // Distrito Federal has only one city and avoids 
        $('#administration').removeAttr('disabled');
    }
  });
});

// set city
var city_name = "";
$(function() {
  $("#city").on('blur', function() {
    city_name = $("#city option:selected").text();
    $('#administration').removeAttr('disabled');
  });
});

// set administration and update section fields
var administration = "";
var form_assembly_params = "";
var deadline = "";
$(function() {
  $("#administration").on('change', function() {
    administration = $("#administration").val();
    $('#school').removeAttr('disabled');
    if(administration == 'Estadual'){
      $.ajax({
        url: '/admin/form_options.json?q%5Bstate_or_city_equals%5D=' + state_name + '&q%5Bdependencia_desc_equals%5D=' + administration,
        method: 'GET',
        success: function(data){
          deadline = data[0].deadline;
          form_assembly_params = data[0].form_assembly_params;
        }
      });
    }
    else{
      $.ajax({
        url: '/admin/form_options.json?q%5Bstate_or_city_equals%5D=' + city_name + '&q%5Bdependencia_desc_equals%5D=' + administration,
        method: 'GET',
        success: function(data){
          deadline = data[0].deadline;
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
      return ('/search.json?state=' + state + '&city=' + city_name +
      '&administration=' + administration + '&school=' + phrase);
    },
    listLocation: 'schools',
    list: {
      onChooseEvent: function() {
        $('#button').removeAttr('disabled');
        var value = $("#school").getSelectedItemData().school_id;
        $("#school_id").val(value).trigger("change");
      }
    }
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
    tfa_3707 = "&tfa_3707=" + $("#school_id").val();
    // prefill inep
    tfa_5 = "&tfa_5=" + id_inep_name[0];
    // prefill school name
    tfa_7 = "&tfa_7=" + id_inep_name[1];
    // prefill person name
    tfa_3719 = "&tfa_3719=" + $("#name").val();
    // prefill person email
    tfa_80 = "&tfa_80=" + $("#email").val();
    // prefill school phone
    tfa_84 = "&tfa_84=" + $("#phone").val();
    // prefill personal phone
    tfa_86 = "&tfa_86=" + $("#personal_phone").val();
    if(administration == 'Estadual'){
      // prefill secretaria 1
      tfa_3710 = "&tfa_3710=Rede Estadual" + ' de ' + state_name;
    }else if (administration == 'Municipal'){
      // prefill secretaria 1
      tfa_3710 = "&tfa_3710=Rede Municipal" + ' de ' + city_name;
    }else {
      // prefill secretaria 1
      tfa_3710 = "&tfa_3710=Rede Federal de Ensino do Brasil"
    }
    // prefill deadline
    tfa_3713 = "";
    if(deadline.length > 0){
      tfa_3713 = "&tfa_3713=" + deadline;
    }

    if(!form_assembly_params){
      form_assembly_params = "tfa_63=1&tfa_64=1&tfa_65=1&tfa_66=1&tfa_2567=1&tfa_2568=1&";
    }
    // create submission
    $.ajax({
      url: '/submissions',
      data: {
        submission:{
          school_id: $("#school_id").val(),
          status: 'redirected',
          school_phone: $("#phone").val(),
          submitter_name: $("#name").val(),
          submitter_email: $("#email").val(),
          submitter_phone: $("#personal_phone").val(),
          redirected_at: new Date()
        }
      },
      method: 'POST'
    });

    window.open(url + form_assembly_params + tfa_3707 + tfa_7 + tfa_5 +
      tfa_3719 + tfa_80 + tfa_84 + tfa_86 + tfa_3707 + tfa_3710 + tfa_3713);
  });
});
