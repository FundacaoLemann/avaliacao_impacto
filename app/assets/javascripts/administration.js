// set administration and update section fields
var administration = "";
var faParams = "";
var deadline = "";
var stateUrl = "";
var cityUrl = "";
var allowed_administrations = [];
getAllowedAministrations();

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
  if (!isAdministrationAllowed()) {
    swal({
      title: 'Olá, a sua rede de ensino não está cadastrada',
      text: 'Por favor, verifique se selecionou a rede corretamente. Caso tenha selecionado a rede corretamente, por favor, entre em contato com a equipe da Fundação Lemann no email formar@fundacaolemann.org.br',
      icon: 'warning',
      closeOnClickOutside: false,
      closeOnEsc: false,
      button: false
    })
  }else {
    $('#school').removeAttr('disabled');
    getFormOption();
  }
}

function isAdministrationAllowed(){
  if (administration == 'Estadual' && allowed_administrations["state_allowed_administrations"].includes(state)){
    return true;
  }else if (administration == 'Municipal' && allowed_administrations["city_allowed_administrations"].includes(city)){
    return true;
  }
  return false;
}

function getAllowedAministrations(){
  $.ajax({
    url: '/allowed_administrations.json',
    method: 'GET',
    success: function(data){
      allowed_administrations = data;
    }
  });
}

// get form assembly params and deadline from admin route
function getFormOption(){
  stateUrl = '/admin/form_options.json?' + 'q%5Bstate_or_city_equals%5D=' + state + '&q%5Bdependencia_desc_equals%5D=Estadual';
  cityUrl = '/admin/form_options.json?' + 'q%5Bstate_or_city_equals%5D=' + city + '&q%5Bdependencia_desc_equals%5D=Municipal';
  adminUrl = administration == 'Municipal' ? cityUrl : stateUrl;
  $.ajax({
    url: adminUrl,
    method: 'GET',
    success: function(data){
      if(data[0]){
        deadline = data[0].deadline;
        faParams = data[0].form_assembly_params;
        formName = data[0].form_name;
      }
    }
  });
}
