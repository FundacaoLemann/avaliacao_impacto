var stateName = "";
$(function() {
  $("#administration_adm").on('change', function() {
    adm = $("#administration_adm").val();
    if (adm == "federal") {
      $("#administration_state_id").prop("disabled", true);
      $("#administration_city_id").prop("disabled", true);
      $("#administration_preposition").prop("disabled", true);

      name = "Rede Federal do Brasil";
      $("#administration_name").val(name).trigger("change");
      $("#administration_cod").val(1).trigger("change");

    }else if (adm == "estadual"){
      $("#administration_city_id").prop("disabled", true);
      $("#administration_state_id").prop("disabled", false);
      $("#administration_preposition").prop("disabled", false);

      $("#administration_state_id").on('change', function() {
        stateName = $("#administration_state_id option:selected").text();
        stateId = $("#administration_state_id option:selected").val();

        name = 'Rede Estadual ' + preposition + " "+ stateName;
        $("#administration_name").val(name).trigger("change");
        $("#administration_cod").val("2-" + stateId).trigger("change");
      });

      $("#administration_preposition").on('change', function() {
        stateName = $("#administration_state_id option:selected").text();
        stateId = $("#administration_state_id option:selected").val();
        preposition = $("#administration_preposition").val();

        name = 'Rede Estadual ' + preposition + " "+ stateName;
        $("#administration_name").val(name).trigger("change");
        $("#administration_cod").val("2-" + stateId).trigger("change");
      });

    }else if (adm == "municipal" || adm == "privada"){
      $("#administration_state_id").prop("disabled", false);
      $("#administration_city_id").prop("disabled", false);
      $("#administration_preposition").prop("disabled", false);
      $("#administration_city_id").html(" ");
      $("#administration_city_id").append('<option value="">' + "Selecione uma cidade" + '</option>');

      $("#administration_state_id").on('change', function() {
        state = $("#administration_state_id").val();
        $("#administration_city_id").html(" ");
        $.ajax({
          url: '/cities/' + state,
          method: 'GET',
          success: function(response){

            for (var i = 0; i < response.length; i++) {
              $("#administration_city_id").append('<option value="' + response[i].id + '">' + response[i].name + '</option>');
            }
          }
        });
      });

      $("#administration_city_id").on('change', function() {
        preposition = $("#administration_preposition").val();
        cityName = $("#administration_city_id option:selected").text();
        cityIbgeCode = $("#administration_city_id option:selected").val();
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
      });

      $("#administration_preposition").on('change', function() {
        cityName = $("#administration_city_id option:selected").text();
        cityIbgeCode = $("#administration_city_id option:selected").val();
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
      });
    }
  });
});
