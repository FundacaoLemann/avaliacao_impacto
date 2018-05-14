var state = "";
var stateName = "";

$(function() {
  $("#state").on('change', function() {
    checkRequiredInputs();
    state = parseInt($("#state").val());
    stateName = $("#state option:selected").text();
    $.ajax({
      url: '/state/' + state,
      method: 'GET'
    });
  });
});

function checkRequiredInputs() {
  name = $("#name").val();
  email = $("#email").val();
  personal_phone = $("#personal_phone").val();
  phone = $("#phone").val();
  if (isEmpty(name) || isEmpty(email) || isEmpty(personal_phone) || isEmpty(phone)) {
    swal({
      title: 'Informações obrigatórias',
      text: 'Antes de prosseguir, por favor preencha as informações de contato acima.',
      icon: 'warning',
    })
  }else{
    $('#city').removeAttr('disabled');
  }
}

function isEmpty(str){
    return !str.replace(/^\s+/g, '').length;
}
