var maskBehavior = function (val) {
  return val.replace(/\D/g, '').length === 11 ? '(00) 00000-0000' : '(00) 0000-00009';
},

options = {onKeyPress: function(val, e, field, options) {
        field.mask(maskBehavior.apply({}, arguments), options);
    }
};

document.addEventListener("turbolinks:load", function() {
  $('#phone').mask(maskBehavior, options);
  $('#personal_phone').mask(maskBehavior, options);
});