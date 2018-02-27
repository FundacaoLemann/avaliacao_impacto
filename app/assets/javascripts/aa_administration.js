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
      console.log(name);
    }else if (adm == "estadual"){
      $("#administration_city_id").prop("disabled", true);
      $("#administration_state_id").prop("disabled", false);
      $("#administration_preposition").prop("disabled", false);

      $("#administration_state_id").on('change', function() {
        stateName = $("#administration_state_id option:selected").text();
        name = 'Rede Estadual ' + preposition + " "+ stateName;
        $("#administration_name").val(name).trigger("change");
      });

      $("#administration_preposition").on('change', function() {
        stateName = $("#administration_state_id option:selected").text();
        preposition = $("#administration_preposition").val();

        name = 'Rede Estadual ' + preposition + " "+ stateName;
        $("#administration_name").val(name).trigger("change");
        console.log(name);
      });
    }else if (adm == "municipal"){
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

        name = 'Rede Municipal ' + preposition + " " + cityName;
        $("#administration_name").val(name).trigger("change");
      });

      $("#administration_preposition").on('change', function() {
        cityName = $("#administration_city_id option:selected").text();
        preposition = $("#administration_preposition").val();

        name = 'Rede Municipal ' + preposition + " " + cityName;
        $("#administration_name").val(name).trigger("change");
      });
    }
  });
});
