/* eslint no-console:0 */

console.log('Hola Mundo desde ESM')

import Rails from "@rails/ujs"
if (typeof window.Rails == 'undefined') {
  Rails.start();
  window.Rails = Rails
}
import {Turbo} from '@hotwired/turbo-rails';

import './jquery'

import 'popper.js'              // Dialogos emergentes usados por bootstrap
import * as bootstrap from 'bootstrap'              // Maquetacion y elementos de diseño
window.bootstrap = bootstrap

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

import Msip__Motor from "./controllers/msip/motor"
window.Msip__Motor = Msip__Motor
Msip__Motor.iniciar()
import Mr519Gen__Motor from "./controllers/mr519_gen/motor"
window.Mr519Gen__Motor = Mr519Gen__Motor
import Heb412Gen__Motor from "./controllers/heb412_gen/motor"
window.Heb412Gen__Motor = Heb412Gen__Motor
import Cor1440Gen__Motor from "./controllers/cor1440_gen/motor"
window.Cor1440Gen__Motor = Cor1440Gen__Motor

import ApexCharts from 'apexcharts'
window.ApexCharts = ApexCharts
import apexes from 'apexcharts/dist/locales/es.json'
Apex.chart = {
  locales: [apexes],
  defaultLocale: 'es',
}

import 'gridstack'

import {AutocompletaAjaxExpreg} from '@pasosdejesus/autocompleta_ajax'
window.AutocompletaAjaxExpreg = AutocompletaAjaxExpreg

let esperarRecursosSprocketsYDocumento = function (resolver) {
  if (typeof window.puntomontaje == 'undefined') {
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
  var root;
  root = window;

  Msip__Motor.ejecutarAlCargarDocumentoYRecursos()  // Este se ejecuta cada vez que se carga una página que no está en cache y tipicamente después de que se ha cargado la página completa y los recursos

  root.cor1440_gen_activa_autocompleta_mismotipo = true
  msip_prepara_eventos_comunes(root);
  heb412_gen_prepara_eventos_comunes(root);
  mr519_gen_prepara_eventos_comunes(root);
  cor1440_gen_prepara_eventos_comunes(root);
})


 /* Lo que debe ejecutarse cada vez que turbo cargue una página,
 * tener cuidado porque puede dispararse el evento turbo varias
 * veces consecutivas al cargar una página.
 */
document.addEventListener('turbo:load', (e) => {
  console.log('Escuchador turbo:load')

  msip_ejecutarAlCargarPagina(window) // Establece root.puntomontaje
  Msip__Motor.ejecutarAlCargarPagina()
  Mr519Gen__Motor.ejecutarAlCargarPagina()
  Heb412Gen__Motor.ejecutarAlCargarPagina()
  Cor1440Gen__Motor.ejecutarAlCargarPagina()
})

import './controllers'
