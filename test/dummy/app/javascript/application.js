/* eslint no-console:0 */

console.log('Hola Mundo desde ESM')

import Rails from "@rails/ujs"
if (typeof window.Rails == 'undefined') {
  Rails.start();
  window.Rails = Rails
}
import {Turbo} from '@hotwired/turbo-rails';

import './jquery'
import '../../vendor/assets/javascripts/jquery-ui'

import 'popper.js'              // Dialogos emergentes usados por bootstrap
import * as bootstrap from 'bootstrap'              // Maquetacion y elementos de diseño

import Msip__Motor from "./controllers/msip/motor"
window.Msip__Motor = Msip__Motor
Msip__Motor.iniciar()
import Mr519Gen__Motor from "./controllers/mr519_gen/motor"
window.Mr519Gen__Motor = Mr519Gen__Motor
Mr519Gen__Motor.iniciar()
import Heb412Gen__Motor from "./controllers/heb412_gen/motor"
window.Heb412Gen__Motor = Heb412Gen__Motor
Heb412Gen__Motor.iniciar()
import Cor1440Gen__Motor from "./controllers/cor1440_gen/motor"
window.Cor1440Gen__Motor = Cor1440Gen__Motor
Cor1440Gen__Motor.iniciar()

import TomSelect from 'tom-select';
window.TomSelect = TomSelect;
window.configuracionTomSelect = {
    create: false,
    diacritics: true, //no sensitivo a acentos
    sortField: {
          field: "text",
          direction: "asc"
        }
}

import ApexCharts from 'apexcharts'
window.ApexCharts = ApexCharts

import 'gridstack'

import {AutocompletaAjaxExpreg} from '@pasosdejesus/autocompleta_ajax'
window.AutocompletaAjaxExpreg = AutocompletaAjaxExpreg

let esperarRecursosSprocketsYDocumento = function (resolver) {
  if (typeof window.puntoMontaje == 'undefined') {
    setTimeout(esperarRecursosSprocketsYDocumento, 100, resolver)
    return false
  }
  if (document.readyState !== 'complete') {
    setTimeout(esperarRecursosSprocketsYDocumento, 100, resolver)
    return false
  }
  resolver("otros recursos manejados con sprockets cargados y documento presentado en navegador")
    return true
  }

let promesaRecursosSprocketsYDocumento = new Promise((resolver, rechazar) => {
  esperarRecursosSprocketsYDocumento(resolver)
})

promesaRecursosSprocketsYDocumento.then((mensaje) => {
  console.log('Cargando recursos sprockets')

  Msip__Motor.ejecutarAlCargarDocumentoYRecursos()
  Mr519Gen__Motor.ejecutarAlCargarDocumentoYRecursos()
  Heb412Gen__Motor.ejecutarAlCargarDocumentoYRecursos()
  Cor1440Gen__Motor.ejecutarAlCargarDocumentoYRecursos()

  $("input[data-behaviour='datepicker']").datepicker({
    format: 'yyyy-mm-dd',
    autoclose: true,
    todayHighlight: true,
    language: 'es'
  })
})


 /* Lo que debe ejecutarse cada vez que turbo cargue una página,
 * tener cuidado porque puede dispararse el evento turbo varias
 * veces consecutivas al cargar una página.
 */
document.addEventListener('turbo:load', (e) => {
  console.log('Escuchador turbo:load')

  Msip__Motor.ejecutarAlCargarPagina()
  Mr519Gen__Motor.ejecutarAlCargarPagina()
  Heb412Gen__Motor.ejecutarAlCargarPagina()
  Cor1440Gen__Motor.ejecutarAlCargarPagina()
})

import './controllers'
