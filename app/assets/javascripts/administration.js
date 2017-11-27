// set administration and update section fields
var administration = "";
var faParams = "";
var deadline = "";
var stateUrl = "";
var cityUrl = "";

$(function() {
  $("#administration").on('change', function() {
    cityName = $("#city option:selected").text();
    city = $("#city").val();
    administration = $("#administration").val();
    checkAllowedAdministrations();
    deadline = "";
    faParams = "";
  });
});

function checkAllowedAdministrations() {
  if (($(".home.index").length > 0) && !isAdministrationAllowed()) {
    swal({
      title: 'Olá, você está no link errado',
      text: 'Não se preocupe. Para ler as instruções corretas e preencher o questionário da sua rede por favor clique no link abaixo.',
      content: {
        element: "a",
        attributes: {
          href: 'http://questionarioformar.fundacaolemann.org.br/fup6271',
          innerHTML: 'Ir para o questionário correto',
        }
      },
      icon: 'warning',
      closeOnClickOutside: false,
      closeOnEsc: false,
      button: false
    })
  }else {
    $('#school').removeAttr('disabled');
    getFormOption(administration);
  }
}

function isAdministrationAllowed(){
  // 3516309 - Francisco Morato | 2111300 - São Luís | 1100205 - Porto Velho
  if((city == '3516309' || city == '2111300' || city == '1100205') && administration == 'Municipal'){
    return true;
  }
  return false;
}

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
                 'q%5Bform_name_eq%5D=baseline' +
                 '&q%5Bstate_or_city_equals%5D=' + state +
                 '&q%5Bdependencia_desc_equals%5D=Estadual';
  if ($(".home.follow_up").length > 0) {
    stateUrl = '/admin/form_options.json?' +
               'q%5Bform_name_eq%5D=follow_up' +
               '&q%5Bstate_or_city_equals%5D=' + state +
               '&q%5Bdependencia_desc_equals%5D=Estadual';
  }
  return stateUrl;
}

// get city url based on the current route
function getCityUrl(){
  var cityUrl = '/admin/form_options.json?' +
                'q%5Bform_name%5D=baseline' +
                '&q%5Bstate_or_city_equals%5D=' + city +
                '&q%5Bdependencia_desc_equals%5D=Municipal';
  if ($(".home.follow_up").length > 0) {
    cityUrl = '/admin/form_options.json?' +
              'q%5Bform_name%5D=baseline' +
              '&q%5Bstate_or_city_equals%5D=' + city +
              '&q%5Bdependencia_desc_equals%5D=Municipal';
  }
  return cityUrl;
}
