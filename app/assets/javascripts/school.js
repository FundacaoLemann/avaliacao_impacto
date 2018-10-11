// school search with select2
document.addEventListener("turbolinks:load", function() {

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

  $("#school").on("select2:select", function (e) {
    $('#button').removeAttr('disabled');
    schoolInepCode = e.params.data.id;
    schoolName = e.params.data.text.split(" | ")[1];
  });

  
});