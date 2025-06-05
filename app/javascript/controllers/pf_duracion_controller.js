import { Controller } from "@hotwired/stimulus"
// Duracion de proecto financiero autocalculada de fecha de inicio y fecha
// de terminacion

export default class extends Controller {
  // Conecta con data-controller="cor1440-gen--pf-duracion"
  //
  // En el campo de fecha duracion agregar: 
  // data-cor1440-gen--pf-duracion-target='duracion'
  //
  // En el campo `fechainicio` agregar: 
  // data-action='change->cor1440-gen--pf-duracion#recalcularDuracion
  // data-cor1440-gen--pf-duracion-target='fechainicio'
  //
  // En el campo `fechafin` agregar: 
  // data-action='change->cor1440-gen--pf-duracion#recalcularDuracion
  // data-cor1440-gen--pf-duracion-target='fechacierre'
  //
  // En el campo de semestreformulacion agregar: 
  // data-cor1440-gen--pf-duracion-target='semestreformulacion'
  //
  // En el campo `fechaformulacion_mes` agregar: 
  // data-action='change->cor1440-gen--pf-duracion#recalcularSemestre
  // data-cor1440-gen--pf-duracion-target='fechaformulacionMes'
 
  static targets = [ 
    "fechainicio", 
    "fechacierre",
    "fechaformulacionMes",
    "duracion",
    "semestreformulacion",
  ]

  initialize() {
    console.log('inicializa controlador pf-duracion')
  }

  connect() {
    console.log('conectado controlador pf-duracion')
  }

  recalcularDuracion(e) {
    console.log("fechainicio=",this.fechainicioTarget.value)
    console.log("fechacierre=", this.fechacierreTarget.value)
    console.log("duracion=", this.duracionTarget.value)

    if (this.fechainicioTarget.value != '' && 
      this.fechacierreTarget.value != '') {
      var purl = window.puntoMontaje;
      if (purl == "/") {
        purl = "";
      }
      window.Rails.ajax({
        type: 'GET',
        url: purl + '/api/cor1440gen/duracion' +
        `?fechainicio=${this.fechainicioTarget.value}`+
        `&fechacierre=${this.fechacierreTarget.value}`,
        data: null,
        success: (resp, estado, xhr) => {
          this.duracionTarget.value = resp.duracion;
        },
        error: (req, estado, xhr) => {
          window.alert('No pudo consultar duración.')
        }
      })
    } else {
      this.duracionTarget.value = ''
    }
  }

  recalcularSemestre(e) {
    console.log("fechaformulacionMes=",this.fechaformulacionMesTarget.value)

    if (this.fechaformulacionMesTarget.value) {
      let semestre = 2
      if (+this.fechaformulacionMesTarget.value <= 6) {
        semestre = 1
      }
      this.semestreformulacionTarget.value = semestre
    }
  }



}
