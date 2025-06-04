import { Controller } from "@hotwired/stimulus"
// Montos en pesos autocalculados

export default class extends Controller {
  // Conecta con data-controller="cor1440-gen--pf-montospesos"
  //
  // En los respectivos campos aagregar:
  // data-cor1440-gen--pf-montospesos-target='monto'
  // data-cor1440-gen--pf-montospesos-target='montopesos'
  // data-cor1440-gen--pf-montospesos-target='aportepropio'
  // data-cor1440-gen--pf-montospesos-target='aportepropiop'
  // data-cor1440-gen--pf-montospesos-target='aotrosfin'
  // data-cor1440-gen--pf-montospesos-target='aporteotrosp'
  // data-cor1440-gen--pf-montospesos-target='saldo'
  // data-cor1440-gen--pf-montospesos-target='saldop'
  // data-cor1440-gen--pf-montospesos-target='presupuestototal'
  // data-cor1440-gen--pf-montospesos-target='presupuestototalp'
  //
  // En los campos con valores que no son en pesos agregar
  // data-action='change->cor1440-gen--pf-montospesos#recalcularMontospesos
 
  static targets = [ 
    "tasaej",
    "montoej",
    "montoejp",
    "aportepropioej",
    "aportepropioejp",
    "aporteotrosej",
    "aporteotrosejp",
    "presupuestototalej",
    "presupuestototalejp"
  ]

  initialize() {
    console.log('inicializa controlador pf-montospesos')
  }

  connect() {
    console.log('conectado controlador pf-montospesos')
  }

  recalcular(e) {
    console.log("montoej=",this["montoejTarget"].value)
    let  sum = 0
    let  sump = 0

    if (this && this.tasaejTarget && this.tasaejTarget.value && 
      this.tasaejTarget.value != ''
    ) {
      let tel = this.tasaejTarget.value
      let te = Msip__Motor.reconocerDecimalLocaleEsCO(tel)
      for (const el of [
        ['montoej', 'montoejp'], 
        ['aportepropioej', 'aportepropioejp'], 
        ['aporteotrosej', 'aporteotrosejp']
      ]) {
        let vl = this[`${el[0]}Target`].value
        let v = Msip__Motor.reconocerDecimalLocaleEsCO(vl)
        sum += v
        let vp = v * te
        let vpl = new Intl.NumberFormat('es-CO').format(vp)
        this[`${el[1]}Target`].value =  vpl
        sump += vp
      }
    }
    let suml = new Intl.NumberFormat('es-CO').format(sum)
    let sumlp = new Intl.NumberFormat('es-CO').format(sump)
    this.presupuestototalejTarget.value = suml
    this.presupuestototalejpTarget.value = sumlp
  }

}
