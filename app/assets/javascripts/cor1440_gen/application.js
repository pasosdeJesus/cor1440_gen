// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require sip/motor
//= require heb412_gen/motor
//= require mr519_gen/motor
//= require cor1440_gen/motor
//= require_tree .


document.addEventListener('turbo:load', function() {
  var root;
  root = window
  root.cor1440_gen_activa_autocompleta_mismotipo = true
  sip_prepara_eventos_comunes(root);
  heb412_gen_prepara_eventos_comunes(root);
  mr519_gen_prepara_eventos_comunes(root);
  cor1440_gen_prepara_eventos_comunes(root);
  $("input[data-behaviour='datepicker']").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true,
    todayHighlight: true,
    language: 'es'
  })


});


