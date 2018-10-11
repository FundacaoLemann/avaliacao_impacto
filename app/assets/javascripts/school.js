// school search
document.addEventListener("turbolinks:load", function() {
 /* $input = $("[data-behavior='search']");
  var options = {
    adjustWidth: false,
    getValue: 'name',
    url: function(phrase) {
      return ('/search.json?city=' + city + '&administration=' + administration
              + '&collect_id=' + collectId + '&adm_cod=' + currentAdm.cod + '&school=' + phrase);
    },
    listLocation: 'schools',
    list: {
      onChooseEvent: function() {
        $('#button').removeAttr('disabled');
        schoolId = $("#school").getSelectedItemData().school_id;
        $("#school_id").val(schoolId).trigger("change");
      }
    }
  }; */

  /*var options2 = {
   // getValue: 'name',
    url: function(phrase) {
      return ('/search.json?city=' + city + '&administration=' + administration
              + '&collect_id=' + collectId + '&=' + currentAdm.cod + '&school=' + phrase);
    }
  };*/
  //$input.easyAutocomplete(options);
 

  //var json_schools = {"schools": [{"id": 1, "text": "Escola 1"}, {"id": 2, "text": "Escola 2"}]};

  /*var select2_var = {
    url: '/search.json',
    delay: 250,
    method: 'GET',
    data: function (params, phrase) {
      var query = {
        search: params.term,
        city: city,
        administration: administration,
        collect_id: collectId,
        adm_cod: currentAdm.cod,
        school: phrase,
      }
      return query;
    },
    /*processResults: function (data, params) {
      return {
        results: $.map(data['schools'], function(value, index){
          return {id: value.id, text: value.name};
        })
      };
    } */ 
//}; 

  $("#school").select2({
    ajax: {
      url: function(params) {
        var school = (!params.term)?'':params.term;      
        return ('/search.json?city=' + city + '&administration=' + administration
                + '&collect_id=' + collectId + '&=' + currentAdm.cod + '&school='+school);
      },
      dataType: 'json',
      data: function (params) {
          search: params.term;
      },
      processResults: function (data) {
        return {
          results: $.map(data["schools"], function(value, index){
            return {id: value.school_id, text: value.school_id + ' | ' + value.name};
          })
        };
      },
      cache: true
    }
  });

});