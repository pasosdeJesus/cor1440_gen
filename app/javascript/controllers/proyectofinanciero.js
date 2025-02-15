export default class Cor1440Gen__ProyectoFinanciero {
  // PROYECTOS

  // DURACIÓN AUTOMÁTICA

  static establecerDuracion(obdur) {
    $('#proyectofinanciero_duracion').val(obdur.duracion)
  }


  static recalcularDuracion() {
    let datos = {
      fechainicio: $('#proyectofinanciero_fechainicio').val(),
      fechacierre: $('#proyectofinanciero_fechacierre').val()
    }
    if (datos.fechainicio!= '' && datos.fechacierre!= '') {
      Msip__Motor.recibirJsonAjax('api/cor1440gen/duracion',
        datos, Cor1440Gen__Proyectofinanciero.establecerDuracion)
    } else {
      $('#proyectofinanciero_duracion').val('')
    }
  }


  static configurarEventosDuracion() {
    $(document).on(
      'change', '#proyectofinanciero_fechaformulacion_mes', (e) => {
      let s = 2
      if ($('#proyectofinanciero_fechaformulacion_mes').val() <= 6) {
        let s = 1
      }
      $('#proyectofinanciero_semestreformulacion').val(s)
    })

    $(document).on('change', '#proyectofinanciero_fechainicio', (e) => {
      Cor1440Gen__Proyectofinanciero.recalcularDuracion()
    })

    $(document).on('change', '#proyectofinanciero_fechacierre', (e) => {
      Cor1440Gen__Proyectofinanciero.recalcularDuracion()
    })

    $(document).on('change', '#proyectofinanciero_fechainicio', (e) => {
      Cor1440Gen__Proyectofinanciero.recalcularDuracion()
    })

    $(document).on('change', '#proyectofinanciero_fechacierre', (e) => {
      Cor1440Gen__Proyectofinanciero.recalcularDuracion()
    })

  }

  // MONTOS EN PESOS AUTOMÁTICOS

  static recalcularAemergentePesosLocalizado(campo, tasa) {
    let vc = $('#' + campo).val()
    if (typeof vc != 'undefined' && vc != '' && typeof tasa != 'undefined' && tasa > 0) {
      let vcp = Msip__Motor.reconocerDecimalLocaleEsCO(vc)*tasa
      let vcpl = new Intl.NumberFormat('es-CO').format(vcp)
      $('#' + campo).attr('title', '$ ' + vcpl).tooltip('fixTitle').tooltip('show')
    }
  }


  static recalcularMontospesosLocalizado() {

    if ($('#proyectofinanciero_tasa_localizado').length > 0) {
      let tfl = $('#proyectofinanciero_tasa_localizado').val()
      let tf = Msip__Motor.reconocerDecimalLocaleEsCO(tfl)
      let sum = 0
      let sump = 0
      $.each(
        [['monto', 'montopesos'], ['aportepropio', 'aportepropiop'],
        ['aotrosfin', 'aporteotrosp'], ['saldo', 'saldop']], (i, c) => {
          let vl = $('#proyectofinanciero_' + c[0] + '_localizado').val()
          let v = Msip__Motor.reconocerDecimalLocaleEsCO(vl)
          sum += v
          let vp = v * tf 
          let vpl = new Intl.NumberFormat('es-CO').format(vp)
          $('#proyectofinanciero_' + c[1] + '_localizado').val(vpl)
          sump += vp
        }
      )
      let suml = new Intl.NumberFormat('es-CO').format(sum)
      let sumpl = new Intl.NumberFormat('es-CO').format(sump)
      $('#proyectofinanciero_presupuestototal_localizado').val(suml)
      $('#proyectofinanciero_presupuestototalp_localizado').val(sumpl)
    }

    // Repetimos para datos en ejecucion
    if ($('#proyectofinanciero_tasaej_localizado').length > 0) {
      let tel = $('#proyectofinanciero_tasaej_localizado').val()
      let te = Msip__Motor.reconocerDecimalLocaleEsCO(tel)
      let sum = 0
      let sump = 0
      $.each(
        [['montoej', 'montoejp'], ['aportepropioej', 'aportepropioejp'],
        ['aporteotrosej', 'aporteotrosejp']], (i, c) => {
          let vl = $('#proyectofinanciero_' + c[0] + '_localizado').val()
          let v = Msip__Motor.reconocerDecimalLocaleEsCO(vl)
          sum += v
          let vp = v * te
          let vpl = new Intl.NumberFormat('es-CO').format(vp)
          $('#proyectofinanciero_' + c[1] + '_localizado').val(vpl)
          sump += vp
        }
      )

      let suml = new Intl.NumberFormat('es-CO').format(sum)
      let sumpl = new Intl.NumberFormat('es-CO').format(sump)
      $('#proyectofinanciero_presupuestototalej_localizado').val(suml)
      $('#proyectofinanciero_presupuestototalejp_localizado').val(sumpl)
    }
  }


  static configurarEventosMontosPesos() {
    $(document).on('change', '#proyectofinanciero_tasa_localizado', (e) => {
      Cor1440Gen__Proyectofinanciero.recalcularMontospesosLocalizado()
    })

    $(document).on('change', '#proyectofinanciero_tasaej_localizado', (e) => {
      Cor1440Gen__Proyectofinanciero.recalcularMontospesosLocalizado()
    })

    $.each(['monto', 'aportepropio', 'aporteotros', 
      'montoej', 'aportepropioej', 'aporteotrosej'], (i, c) => {
        $(document).on(
          'change', '#proyectofinanciero_' + c + '_localizado', (e) => {
            Cor1440Gen__Proyectofinanciero.recalcularMontospesosLocalizado()
          })
      })

  }

}
