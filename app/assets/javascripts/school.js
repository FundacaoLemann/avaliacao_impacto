// school search
document.addEventListener("turbolinks:load", function() {
  $input = $("[data-behavior='search']");
  var options = {
    getValue: 'name',
    url: function(phrase) {
      return ('/search.json?state=' + state + '&city=' + cityName +
      '&administration=' + administration + '&school=' + phrase);
    },
    listLocation: 'schools',
    list: {
      onChooseEvent: function() {
        $('#button').removeAttr('disabled');
        schoolId = $("#school").getSelectedItemData().school_id;
        $("#school_id").val(schoolId).trigger("change");
      }
    }
  };

  $input.easyAutocomplete(options);
});
