var formName = "";
var formUrl = "";
$(function() {
  $("input[type=submit]").on('click', function(e) {
    e.preventDefault();
    if (!isAdministrationAllowed()) {
      swal({
        title: 'Olá, a sua rede de ensino não está cadastrada',
        text: 'Por favor, verifique se selecionou a rede corretamente.\
          Caso tenha selecionado a rede corretamente, por favor, entre em\
          contato com a equipe da Fundação Lemann no email formar@fundacaolemann.org.br',
        icon: 'warning'
      })
      throw new Error("ForbiddenAdministration");
    }

    // prefill inep
    tfa_5 = "&tfa_5=" + schoolInepCode;
    // prefill school name
    tfa_7 = "&tfa_7=" + schoolName;
    // prefill person name
    tfa_3719 = "&tfa_3719=" + $("#name").val();
    // prefill person email
    tfa_80 = "&tfa_80=" + $("#email").val();
    // prefill school phone
    tfa_84 = "&tfa_84=" + $("#phone").val();
    // prefill personal phone
    tfa_86 = "&tfa_86=" + $("#personal_phone").val();
    // prefill collect id
    tfa_5749 = "&tfa_5749=" + collectId;
    // prefill rede de ensino
    tfa_3710 = "&tfa_3710=" + currentAdm.name;
    // prefill deadline
    tfa_3713 = "";
    if(deadline){
      tfa_3713 = "&tfa_3713=" + deadline;
    }

    if(!faParams){
      faParams = "tfa_63=1&tfa_64=1&tfa_65=1&tfa_66=1&tfa_2567=1&tfa_2568=1&tfa_5733=1&tfa_5734=1&tfa_5735=1&tfa_5736=1&tfa_5737=1&tfa_5738=1&tfa_5739=1&tfa_5740=1&tfa_5741=1&";
    }

    // Disable the submit button while the requests are beign loaded
    $('#button').attr('disabled', true);

    getForm(formId);
  });
});

function getForm(form_id){
  $.ajax({
    url: '/form.json',
    method: 'GET',
    data: { id: form_id },
    success: function(data){
      formUrl = data.link;
      formName = data.name;

      createSubmission();
    },
    error: function(error){
      // If something went wrong, re-enable the submit button
      $('#button').removeAttr('disabled');
    }
  });
}


function createSubmission() {
  $.ajax({
    url: '/submissions',
    data: {
      submission:{
        form_name: formName,
        school_inep: schoolInepCode,
        status: 'redirected',
        school_phone: $("#phone").val(),
        submitter_name: $("#name").val(),
        submitter_email: $("#email").val(),
        submitter_phone: $("#personal_phone").val(),
        redirected_at: new Date(),
        adm_cod: currentAdm.cod,
        collect_id: collectId
      }
    },
    method: 'POST',
    success: function(data){
      openForm();
    },
    error: function(error){
      // If something went wrong, re-enable the submit button
      $('#button').removeAttr('disabled');
    }
  });
}

function openForm() {
  window.location.href = (formUrl + "?" + faParams + tfa_7 + tfa_5 + tfa_3719 +
    tfa_80 + tfa_84 + tfa_86 + tfa_3710 + tfa_3713 + tfa_5749);
}
