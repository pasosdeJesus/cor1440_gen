/* eslint no-console:0 */

console.log('Hola Mundo desde ESM')


import Rails from "@rails/ujs";
import "@hotwired/turbo-rails";
Rails.start();
window.Rails = Rails

import './jquery'
import '../../vendor/assets/javascripts/jquery-ui'

import 'popper.js'              // Dialogos emergentes usados por bootstrap
import * as bootstrap from 'bootstrap'              // Maquetacion y elementos de diseño
import 'chosen-js/chosen.jquery';       // Cuadros de seleccion potenciados
import 'bootstrap-datepicker'
import 'bootstrap-datepicker/dist/locales/bootstrap-datepicker.es.min.js'

import ApexCharts from 'apexcharts'
window.ApexCharts = ApexCharts

import 'gridstack'

import {AutocompletaAjaxExpreg} from '@pasosdejesus/autocompleta_ajax'
window.AutocompletaAjaxExpreg = AutocompletaAjaxExpreg


function otrosRecursosCargados(resolver) {
  if (typeof window.puntomontaje == 'undefined') {
    setTimeout(otrosRecursosCargados, 250, resolver)
    return false
  }
  resolver("otros recursos cargados")
  return true
}

let promesaOtrosRecursosCargados = new Promise((resolver, rechazar) => {
  otrosRecursosCargados(resolver)
})

promesaOtrosRecursosCargados.then((mensaje) => {
  // Lo que se necesita inicializar después de cargar recursos manejados por
  // sprockets
  console.log('Ejecutando inicialización de otros recursos manejados por sprockets')
  var root = window 
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

})

