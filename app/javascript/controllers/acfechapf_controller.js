import { Controller } from "@hotwired/stimulus"

/**
 * En una actividad mantiene consistencia entre la fecha de la actividad
 * y la vigencia de los proyectos financieros de la actividad.
 *
 * * Conecta por ejemplo en form con
 *   data-controller="cor1440-gen--acfechapf"
 * * En el campo de fecha agrega:
 *    ```
 *    data-action="change->cor1440-gen--acfechapf#cambiarFecha"
 *    data-cor1440-gen--acfechapf-target="fecha"
 *    ```
 * * En cada proyectofinanciero agrega:
 *   data-cor1440-gen--acfechapf-target="pf"
 */
export default class Cor1440Gen__AcfechapfController extends Controller {
  static targets = [ 
    "fecha",
    "pf"
  ]

  initialize() {
    console.log('inicializa controlador acfechapf')
  }


  connect() {
    console.log('conectado controlador acfechapf')
  }


  cambiarFecha(e) {

    var purl = window.puntoMontaje;
    if (purl == "/") {
      purl = "";
    }

    if (this.fechaTarget == null) {
      alert("acfechapf: Falta marcar elemento fecha");
      return;
    }
    if (this.pfTargets == null || this.pfTargets.length == 0) {
      return;
    }
    const params = {
      fecha: this.fechaTarget.value
    }
    const paramUrl = new URLSearchParams(params).toString();
    document.body.style.cursor = 'wait'
    const url = `${purl}/proyectosfinancieros?${paramUrl}`
    fetch(url, {
      method: 'GET',
      headers: {
        'X-CSRF-Token': document.querySelector('meta[name="csrf-token"]').getAttribute('content'),
        'Accept': 'application/json'
      },
      data: params, 
    }).then( response  => response.json())
      .then( json => {
      document.body.style.cursor = 'default'
      debugger
    }).catch( error => {
      document.body.style.cursor = 'default'
      alert(`Error al enviar: ${error.message}`);
    });
  }


}
