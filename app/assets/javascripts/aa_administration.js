var stateName = "";
var stateId = "";
$(function() {
  $("#administration_adm").on('change', function() {
    adm = $("#administration_adm").val();
    if (adm == "federal") {
      $("#administration_state_id").prop("disabled", true);
      $("#administration_city_ibge_code").prop("disabled", true);
      $("#administration_preposition").prop("disabled", true);

      name = "Rede Federal do Brasil";
      $("#administration_name").val(name).trigger("change");
      $("#administration_cod").val(1).trigger("change");

    }else if (adm == "estadual"){
      $("#administration_city_ibge_code").prop("disabled", true);
      enableStateAndPreposition();

      $("#administration_state_id").on('change', function() {
        getStateValues();

        name = 'Rede Estadual ' + preposition + " "+ stateName;
        $("#administration_name").val(name).trigger("change");
        $("#administration_cod").val("2-" + stateId).trigger("change");
      });

      $("#administration_preposition").on('change', function() {
        getStateValues();
        preposition = $("#administration_preposition").val();

        name = 'Rede Estadual ' + preposition + " "+ stateName;
        $("#administration_name").val(name).trigger("change");
        $("#administration_cod").val("2-" + stateId).trigger("change");
      });

    }else if (adm == "municipal" || adm == "privada"){
      enableStateAndPreposition();
      $("#administration_city_ibge_code").prop("disabled", false);
      $("#administration_city_ibge_code").html(" ");
      $("#administration_city_ibge_code").append('<option value="">' + "Selecione uma cidade" + '</option>');

      $("#administration_state_id").on('change', function() {
        state = $("#administration_state_id").val();
        $("#administration_city_ibge_code").html(" ");
        $.ajax({
          url: '/cities/' + state,
          method: 'GET',
          success: function(response){

            for (var i = 0; i < response.length; i++) {
              $("#administration_city_ibge_code").append('<option value="' + response[i].ibge_code + '">' + response[i].name + '</option>');
            }
          }
        });
      });

      $("#administration_city_ibge_code").on('change', function() {
        getCityValues();
      });

      $("#administration_preposition").on('change', function() {
        getCityValues();
      });
    }
  });
});

function getStateValues(){
  stateName = $("#administration_state_id option:selected").text();
  stateId = $("#administration_state_id option:selected").val();
}

function getCityValues(){
  cityName = $("#administration_city_ibge_code option:selected").text();
  cityIbgeCode = $("#administration_city_ibge_code option:selected").val();
  preposition = $("#administration_preposition").val();

  admCode = ""
  admType = ""
  if(adm == "municipal"){
    admType = "Rede Municipal "
    admCode = "3-"
  }else{
    admType = "Rede Privada "
    admCode = "4-"
  }
  name = admType + preposition + " " + cityName;
  $("#administration_name").val(name).trigger("change");
  $("#administration_cod").val(admCode + cityIbgeCode).trigger("change");
}

function enableStateAndPreposition(){
  $("#administration_state_id").prop("disabled", false);
  $("#administration_preposition").prop("disabled", false);
}
