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

document.addEventListener('turbolinks:load', function() {
  var root;
  root = typeof exports !== "undefined" && exports !== null ? 
    exports : window;
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


  // En actividad si se cambia sexo de un asistente
  // recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_sexo]:visible', function (e) {
    if (typeof cor1440_gen_recalcula_poblacion == 'function') {
      cor1440_gen_recalcula_poblacion();
    }
  })

  // En actividad si se cambia anio de nacimiento de un asistente
  // recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_anionac]:visible', function (e) {
    if (typeof cor1440_gen_recalcula_poblacion == 'function') {
      cor1440_gen_recalcula_poblacion();
    }
  })

  // En actividad si se cambia mes de nacimiento de un asistente
  // recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_mesnac]:visible', function (e) {
    if (typeof cor1440_gen_recalcula_poblacion == 'function') {
      cor1440_gen_recalcula_poblacion();
    }
  })

  // En actividad si se cambia dia de nacimiento de un asistente
  // recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_dianac]:visible', function (e) {
    if (typeof cor1440_gen_recalcula_poblacion == 'function') {
      cor1440_gen_recalcula_poblacion();
    }
  })


  // En actividad tras eliminar asistencia recalcular población
  $('#asistencia').on('cocoon:after-remove', function (e, papa) {
    if (typeof cor1440_gen_recalcula_poblacion == 'function') {
      cor1440_gen_recalcula_poblacion();
    }
  })

  // Tras autocompletar asistente
  $(document).on('cor1440gen:autocompletado-asistente', function (e, papa) {
    if (typeof cor1440_gen_recalcula_poblacion == 'function') {
      cor1440_gen_recalcula_poblacion();
    }
  })


});


