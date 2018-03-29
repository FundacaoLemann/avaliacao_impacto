// set administration and update section fields
var administration = "";
var faParams = "";
var deadline = "";
var stateUrl = "";
var cityUrl = "";
var allowed_administrations = [];
var currentAdm = "";
var formId = "";
var collectId = "";

getAllowedAministrations();

$(function() {
  $("#administration").on('change', function() {
    cityName = $("#city option:selected").text();
    city = parseInt($("#city").val());
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
      text: 'Por favor, verifique se selecionou a rede corretamente.\
      Caso tenha selecionado a rede corretamente, por favor, entre em contato\
      com a equipe da Fundação Lemann no email formar@fundacaolemann.org.br',
      icon: 'warning',
    })
  }else {
    $('#school').removeAttr('disabled');
    getCollectParams();
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

function getAministration(param){
  $.ajax({
    url: '/administration.json',
    method: 'GET',
    data: { city_or_state: param },
    success: function(data){
      currentAdm = data;
    }
  });
}

function getCollect(adm_id){
  $.ajax({
    url: '/collect.json',
    method: 'GET',
    data: { adm: adm_id },
    success: function(data){
      if(data){
        collectId = data.id;
        deadline = data.deadline;
        faParams = data.form_assembly_params;
        formId = data.form_id;
      }
    }
  });
}

function getCollectParams(){
  administration == 'Municipal' ? getAministration(city) : getAministration(state);
  getCollect(currentAdm.id);
}
