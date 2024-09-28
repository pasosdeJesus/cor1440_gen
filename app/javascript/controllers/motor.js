import Cor1440Gen__AutocompletaAjaxAsistentes from 
  "./AutocompletaAjaxAsistentes"
window.Cor1440Gen__AutocompletaAjaxAsistentes = 
  Cor1440Gen__AutocompletaAjaxAsistentes 

import Cor1440Gen__Mindicadorespf from "./mindicadorespf"
window.Cor1440Gen__Mindicadorespf = Cor1440Gen__Mindicadorespf

import Cor1440Gen__Proyectofinanciero from "./proyectofinanciero"
window.Cor1440Gen__Proyectofinanciero = Cor1440Gen__Proyectofinanciero

export default class Cor1440Gen__Motor {
  /* 
   * Librería de funciones comunes.
   * Aunque no es un controlador lo dejamos dentro del directorio
   * controllers para aprovechar método de msip para compartir controladores
   * Stimulus de motores.
   *
   * Como su nombre no termina en _controller no será incluido en 
   * controllers/index.js
   *
   * Desde controladores stimulus importelo con
   *
   *  import Cor1440Gen__Motor from "../cor1440_gen/motor"
   *
   * Use funciones por ejemplo con
   *
   *  Cor1440Gen__Motor.ejecutarAlCargarPagina()
   *
   * Para poderlo usar desde Javascript global con window.Cor1440Gen__Motor 
   * asegure que en app/javascript/application.js ejecuta:
   *
   * import Cor1440Gen__Motor from './controllers/cor1440_gen/motor.js'
   * window.Cor1440Gen__Motor = Cor1440Gen__Motor
   *
   */


  // Se ejecuta cada vez que se carga una página que no está en cache
  // y tipicamente después de que se ha cargado la página y los recursos.
  static ejecutarAlCargarDocumentoYRecursos(opciones = {}) {
    console.log("* Corriendo Cor1440Gen__Motor.ejecutarAlCargarDocumentoYRecursos()")

    Cor1440Gen__Mindicadorespf.preparar()

    $(document).on('click', '.envia_filtrar', e => {
      let f = e.target.form
      let a = f.action
      if (a.endsWith(".pdf")) {
        $(f).attr("action", a.substr(0, a.length-4))
        $(f).removeAttr("target")
      }
    })
    $(document).on('click', '.envia_generar_pdf', (e) => {
      let f = e.target.form
      let a = f.action
      if (!a.endsWith(".pdf")) {
        $(f).attr("action", a + ".pdf")
        $(f).attr("target", "_blank")
      }
    })

    if (!opciones['sin_eventos_cambia_proyecto']) {
      $('#actividad_fecha').on('change', (ev) => {
        Cor1440Gen__Motor.actualizarActividadFecha2()
      })

      // Tras añadir una fila a la tabla de proyectosfinancieros y sus
      // actividadespf, se deja proyecto en blanco y se permite elegir uno de
      // entre los vigentes pero excluyendos los que ya estuvieran
      // (para evitar filas repetidas)
      $(document).on('cocoon:after-insert', '#actividad_proyectofinanciero', 
        (e, objetivo) => {
          Msip__Motor.configurarElementosTomSelect()
          window.Msip__Motor.configurarElementosTomSelect()
          let params = {
            fecha: $('#actividad_fecha').val(),
          }
          if ($('#actividad_grupo_ids').length > 0) {
            params['grupo_ids'] = $('#actividad_grupo_ids').val()
          }

          Msip__Motor.funcion1pTrasAJAX('proyectosfinancieros', params,
            Cor1440Gen__Motor.actualizarActividad_pf_op, objetivo,
            'con Convenios Financiados')
        })

      // Al eliminar una fila de la tabla
      // se retiran subformularios de actividades de convenio
      $(document).on('cocoon:after-remove', '#actividad_proyectofinanciero', 
        (e, objetivo) => {
          Cor1440Gen__Motor.actualizarActividadCamposDinamicos2()
        })

      // Al establecer un proyectofinanciero se deshabilita
      // posibilidad de edición al mismo y en la celda de actividades
      // de convenio se permite elegir entre las del proyecto elegido
      $(document).on(
        'change', 
        'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=proyectofinanciero_id]', (e, res) => {
          // El parametro res sería enviado por chosen pero no por tom-select
          // Deshabilitar edición y dejar disponibles actividades de convenio
          $(e.target).attr('disabled', true)
          // Como deshabilitamos un select, creamos un input con el mismo nombre y
          // valor para que al enviar el formulario no se pierda la información
          let el = document.createElement('input')
          el.setAttribute('name', e.target.name)
          el.setAttribute('type', 'hidden')
          el.setAttribute('value', e.target.value)
          e.target.parentNode.append(el)
          Msip__Motor.configurarElementoTomSelect(e.target)
          idac = $(e.target).parent().parent().parent().find('select[id$=actividadpf_ids]').attr('id')
          let params = { pfl: [+e.target.value]}
          Msip__Motor.llenaSelectConAJAX2('actividadespf', params,
            idac, 'con Actividades de convenio ' + e.target.value,
            'id', 'nombre', null)
        })

      // Antes de enviar el formulario de actividad, habilitamos campos
      // proyectofinanciero, que se habían deshabilitado para simplificar
      // interacción por parte de usuario.
      $("form[id^=edit_actividad]").submit(() => {
        $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_proyectofinanciero_id]').removeAttr('disabled')
        $('select[id^=actividad_actividad_rangoedadac_attributes_][id$=_rangoedadac_id]').removeAttr('disabled')
        $('select[id^=actividad_detallefinanciero_attributes_][id$=_convenioactividad]').removeAttr('disabled')

      })

      // Tras agregar o eliminar actividades de convenio a un convenio
      // agregare o eliminar subformularios asociados
      $(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=actividadpf_ids]', (e, res) => {
        if (typeof window.cor1440_gen_activa_autocompleta_mismotipo != 'undefined' && window.cor1440_gen_activa_autocompleta_mismotipo == true) {
          Cor1440Gen__Motor.actualizarActividad_mismotipo(res)
        }
        if (typeof window.cor1440_gen_activa_autocompletaConAncestros != 'undefined' && window.cor1440_gen_activa_autocompletaConAncestros == true) {
          Cor1440Gen__Motor.actualizarActividadConAncestros(res)
        }

        Cor1440Gen__Motor.actualizarActividadCamposDinamicos2()
      })
    }

    $(document).on('change', '#objetivospf [id$=_numero]', Cor1440Gen__Motor.actualizarObjetivos)

    $(document).on('cocoon:after-remove', '#objetivospf', Cor1440Gen__Motor.actualizarObjetivos)

    $(document).on('cocoon:after-insert', '#objetivospf', Cor1440Gen__Motor.actualizarObjetivos)

    $(document).on('cocoon:before-remove', '#objetivospf', (e, objetivo) => {
      Msip__Motor.intentaEliminarFila(
        objetivo, '/objetivospf/', Cor1440Gen__Motor.DEP_OBJETIVOPF
      )
    })

    $(document).on('cocoon:before-remove', '#indicadoresobjetivos', (e, indicador) => {
      Msip__Motor.intentaEliminarFila(
        indicador, '/indicadorespf/', Cor1440Gen__Motor.DEP_INDICADORPF
      )
    })

    $(document).on('change', '#indicadoresobjetivos [id$=_id]', (e, result) => {
      Msip__Motor.enviarAutomaticoFormulario($('form'), 'POST', 'json', false, 'Enviar')
    })
    $(document).on(
      'cocoon:after-insert', '#indicadoresobjetivos',
      Cor1440Gen__Motor.actualizarObjetivos
    )
    $(document).on(
      'change', '#resultadospf [id$=_numero]', 
      Cor1440Gen__Motor.actualizarResultados
    )
    $(document).on(
      'cocoon:after-remove', '#resultadospf', 
      Cor1440Gen__Motor.actualizarResultados
    )
    $(document).on(
      'cocoon:after-insert', '#resultadospf', 
      Cor1440Gen__Motor.actualizarObjetivos
    )
    $(document).on(
      'cocoon:before-remove', '#resultadospf', (e, resultado) => {
        Msip__Motor.intentaEliminarFila(
          resultado, '/resultadospf/', Cor1440Gen__Motor.DEP_RESULTADOPF
        )
      })

    $(document).on('change', '#resultadospf [id$=_id]', (e, result) => {
      Msip__Motor.enviarAutomaticoFormulario(
        $('form'), 'POST', 'json', false, 'Enviar'
      )
    })


    $(document).on('cocoon:before-remove', '#indicadorespf', (e, indicador) => {
      Msip__Motor.intentaEliminarFila(
        indicador, '/indicadorespf/', Cor1440Gen__Motor.DEP_INDICADORPF
      )
    })

    $(document).on('change', '#indicadorespf [id$=_id]', (e, result) => {
      Msip__Motor.enviarAutomaticoFormulario(
        $('form'), 'POST', 'json', false, 'Enviar'
      )
    })

    $(document).on(
      'cocoon:after-insert', '#indicadorespf', 
      Cor1440Gen__Motor.actualizarResultados
    )

    $(document).on(
      'cocoon:after-insert', '#actividadespf',
      Cor1440Gen__Motor.actualizarResultados
    )
    $(document).on('change', '#actividadespf [id$=_id]', (e, result) => {
      Msip__Motor.enviarAutomaticoFormulario(
        $('form'), 'POST', 'json', false, 'Enviar'
      )
    })

    // En listado de asistencia permite autocompletar nombres
    Cor1440Gen__AutocompletaAjaxAsistentes.iniciar()

    // En medición de indicadores, elegir convenio hace click
    $(document).on('change', '[data-enviar-haciendo-click]', (e, result) => {
      $('[name=' + $(this).data('enviar-haciendo-click') + ']').trigger('click')
    })

    $(document).on('cocoon:after-insert', '#pmindicadorpf', (e, objetivo) => {
      let dids = $.map($('[name^=datosintermediosti]'), (e) => +e.value)
      let cuenta = objetivo.parent().parent().
        find('input[name^=datosintermediosti]').length - 1
      let idpm = +objetivo.find(
        'input[id^=mindicadorpf_pmindicadorpf_attributes_][id$=_id]'
      )[0].id.match(/mindicadorpf_pmindicadorpf_attributes_([0-9]*)_id/)[1]
      objetivo.parent().parent().find('input[name^=datosintermediosti]').each(
        (d) => {
          $(objetivo.children('td')[4]).before('<td> <div class="input float optional mindicadorpf_pmindicadorpf_datointermedioti_pmindicadorpf_valor"><input class="numeric float optional form-control span10" type="number" step="any" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][valor]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_valor" style="background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);"></div><div class="input hidden mindicadorpf_pmindicadorpf_datointermedioti_pmindicadorpf_rutaevidencia"><input class="hidden form-control span10" type="hidden" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][rutaevidencia]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_rutaevidencia" style="background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);"></div><input class="hidden form-control span10" type="hidden" value="' + dids[cuenta] + '" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][datointermedioti_id]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_datointermedioti_id"> <input class="hidden form-control span10" type="hidden" value="" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][id]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_id"></td>')
          cuenta--
        })
    })


    // Beneficiarios
    // Campos dinámicos
    $(document).on(
      'change', 'select[id=persona_proyectofinanciero_ids]', (e, res) => {
        Cor1440Gen__Motor.actualizarmicos()
      }
    )

    Cor1440Gen__Proyectofinanciero.configurarEventosDuracion()
    Cor1440Gen__Proyectofinanciero.configurarEventosMontosPesos()

  }

  // Llamar cada vez que se cargue una página detectada con turbo:load
  // Tal vez en cache por lo que podría no haberse ejecutado iniciar 
  // nuevamente.
  // Podría ser llamada varias veces consecutivas por lo que debe detectarlo
  // para no ejecutar dos veces lo que no conviene.
  static ejecutarAlCargarPagina() {
    console.log("* Corriendo Cor1440Gen__Motor.ejecutarAlCargarPagina()")
  }


  // Se ejecuta desde app/javascript/application.js tras importar el motor
  static iniciar() {
    console.log("* Corriendo Cor1440Gen__Motor.iniciar()")
  }



  static DEP_OBJETIVOPF = [
    'select[id^=proyectofinanciero_resultadopf_attributes][id$=_objetivopf_id]',
    'select[id^=proyectofinanciero_indicadorobjetivo_attributes][id$=_objetivopf_id]'
  ]

  static DEP_RESULTADOPF = [
    'select[id^=proyectofinanciero_indicadorpf_attributes][id$=_resultadopf_id]',
    'select[id^=proyectofinanciero_actividadpf_attributes][id$=_resultadopf_id]'
  ]

  static DEP_INDICADORPF = []


  static funEtiquetaResultadopf(jv) {
    let et = jv.find('select[id$=_objetivopf_id] option[selected]').text() +
      jv.find('input[id$=_numero]').val()
    return et
  }

  static actualizarObjetivos(e, objetivo) {
    Msip__Motor.actualizaCuadrosSeleccionDependientes(
      'objetivospf', '_id', '_numero', 
      Cor1440Gen__Motor.DEP_OBJETIVOPF, 'id', 'numero'
    )
    Msip__Motor.actualizaCuadrosSeleccionDependientesFunEtiqueta(
      'resultadospf', '_id', cor1440_gen_fun_etiqueta_resultadopf,
      Cor1440Gen__Motor.DEP_RESULTADOPF, 'id', 'numero'
    )
  }

  static actualizarResultados(e, resultado) {
    Msip__Motor.actualizaCuadrosSeleccionDependientesFunEtiqueta(
      'resultadospf', '_id', cor1440_gen_fun_etiqueta_resultadopf,
      Cor1440Gen__Motor.DEP_RESULTADOPF, 'id', 'numero'
    )
  }


  // En formulario actividad

  // Actualiza campos dinámicos cuando hay un solo campo de actividades de proyectofinanciero
  static actualizarActividadmicos() {
    let ruta = document.location.pathname
    if (ruta.length == 0) {
      return
    }
    if (ruta.startsWith(window.puntoMontaje)) {
      ruta = ruta.substr(window.puntoMontaje.length)
    }
    if (ruta[0] == '/') {
      ruta = ruta.substr(1)
    }
    let params = {
      actividadpf_ids: $('#actividad_actividadpf_ids').val()
    }
    Msip__Motor.enviaAjaxDatosRutaYPinta(
      ruta, params, '#camposdinamicos', '#camposdinamicos'
    )
  }

  static llenarActividadpfRelacionadas(res) {
    let ac_relacionadas = res.ac_ids_relacionadas
    let val_actuales = []
    if (ac_relacionadas.length > 0) {
      $('#actividad_proyectofinanciero tr').not(':hidden').each(() => {
        let val_actuales = $(this).find('select[id$=actividadpf_ids]').val()
        if (val_actuales.length > 0) {
          ac_relacionadas = ac_relacionadas.concat(val_actuales)
        }
      })
      $('#actividad_proyectofinanciero tr').not(':hidden').each(() => {
        $(this).find('select[id$=actividadpf_ids]').val(ac_relacionadas)
        $(this).find('select[id$=actividadpf_ids]').each((el) => {
          Msip__Motor.configurarElementoTomSelect(el)
        })
      })
    }
  }

  static actualizarActividadMismoTipo(res) {
    if (res.selected) {
      let acids = ['']
      $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_actividadpf_ids]').each( () => {
        let t = $(this)
        if (t.parent().parent().parent().not(':hidden').length > 0) {
          let acids = acids.concat(t.val())
        }
      })
      let prids = []
      $('#actividad_proyectofinanciero tr').not(':hidden').each(() => {
        let idex = $(this).find('select[id$=proyectofinanciero_id]').val()
        prids.push(idex)
      })
      let params = {
        actividadpf_ids: acids,
        proyectofinanciero_ids: prids
      }
      Msip__Motor.ajaxRecibeJson(
        'api/actividades/relacionadas',
        params, cor1440_gen_llenarActividadpf_relacionadas
      )
    }
  }


  static llenarActividadpfConAncestros(res) {
    let acConAncestros = res.ac_idsConAncestros
    $('select[id^=actividad_actividad_proyectofinanciero_attributes][id$=actividadpf_ids]').each(() => {
      let actuales = $(this).val()
      // acConAncestros incluye los actuales
      let posibles = []
      $(this).find('option').each(() => {
        posibles.push(+this.value)
      })
      let int = posibles.filter( (v) => acConAncestros.includes(v))
      $(this).val(int)
      Msip__Motor.configurarElementoTomSelect(this)
      if (int.length != actuales.length) {
        $(this).trigger('cor1440_gen:conancestros_actualizado')
      }
    })
  }


  static actualizarActividadConAncestros(res) {
    if (res.selected) {
      let acids = ['']
      $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_actividadpf_ids]').each( () => {
        let t = $(this)
        if (t.parent().parent().parent().not(':hidden').length > 0) {
          acids = acids.concat(t.val())
        }
      })
      let prids = []
      $('#actividad_proyectofinanciero tr').not(':hidden').each(() => {
        idex = $(this).find('select[id$=proyectofinanciero_id]').val()
        prids.push(idex)
      })
      let params = {
        actividadpf_ids: acids,
        proyectofinanciero_ids: prids
      }
      Msip__Motor.ajaxRecibeJson(
        'actividadespf/conancestros', params, 
        Cor1440Gen__Motor.llenarActividadpfConAncestros
      )
    }
  }


  // Actualiza campos dinámicos cuando hay una tabla de proyectofinanciero
  // y actividades de proyectofinanciero
  static actualizarActividadCamposDinamicos2() {
    let ruta = document.location.pathname
    if (ruta.length == 0) {
      return
    }
    if (ruta.startsWith(window.puntoMontaje)) {
      ruta = ruta.substr(window.puntoMontaje.length)
    }
    if (ruta[0] == '/') {
      ruta = ruta.substr(1)
    }
    let acids = ['']
    $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_actividadpf_ids]').each( () => {
      let t = $(this)
      if (t.parent().parent().parent().not(':hidden').length > 0) {
        acids = acids.concat(t.val())
      }
    })

    let params = {
      actividadpf_ids: acids
    }
    Msip__Motor.enviaAjaxDatosRutaYPinta(
      ruta, params, '#camposdinamicos', '#camposdinamicos'
    )
  }

  static actualizarActividadActividadpfPf(proyectofinanciero_id) {
    let params = {
      pfl: [proyectofinanciero_id]
    }
    Msip__Motor.llenaSelectConAJAX2(
      'actividadespf', params,
      'actividad_actividadpf_ids', 'con Actividades de convenio', 
      'id', 'nombre', Cor1440Gen__Motor.actualizarActividadmicos
    )
  }


  static actualizarActividadActividadpf() {
    let params = {
      pfl: $('#actividad_proyectofinanciero_ids').val(),
    }
    Msip__Motor.llenaSelectConAJAX2(
      'actividadespf', params,
      'actividad_actividadpf_ids', 'con Actividades de convenio',
      'id', 'nombre', Cor1440Gen__Motor.actualizarActividadmicos
    )
  }


  static actualizarActividadPf() {
    let params = {
      fecha: $('#actividad_fecha').val(),
    }
    Msip__Motor.llenaSelectConAJAX2(
      'proyectosfinancieros', params,
      'actividad_proyectofinanciero_ids', 'con Convenios financiados',
      'id', 'nombre',
      Cor1440Gen__Motor.actualizarActividadActividadpf
    )
  }


  static actualizarActividadPf2(pfpend = null) {
    // Si hay listado de proyectos vigentes, limitar a esos
    if (pfpend != null) {
      let pfpendid = pfpend.map((e) => (e.id))
      let pfex = []
      $('#actividad_proyectofinanciero tr').not(':hidden').each(() => {
        let idex = $(this).find('select[id$=proyectofinanciero_id]').val()
        if (!(pfpendid.includes(+idex))) {
          $(this).remove()
        }
      })
    }
    // Actualizar campos dinámicos
    Cor1440Gen__Motor.actualizarActividadCamposDinamicos2()
  }

  static limitarActividadPfActualizaActividadpf(pfpend = null) {
    // Si hay listado de proyectos vigentes, limitar a esos
    if (pfpend != null) {
      let pfpendid = pfpend.map((e) => (e.id))
      let pfex = []
      $('#actividad_proyectofinanciero tr').not(':hidden').each(() => {
        let idex = $(this).find('select[id$=proyectofinanciero_id]').val()
        if (!(pfpendid.includes(+idex))) {
          $(this).remove()
        }
      })
    }
  }

  static actualizarActividadFecha2() {
    let params = {
      fecha: $('#actividad_fecha').val(),
    }
    Msip__Motor.funcionTrasAJAX(
      'proyectosfinancieros', params,
      Cor1440Gen__Motor.actualizarActividad_pf2, 'con Convenios Financiados'
    )
  }

  static actualizarActividadPfOp(resp, objetivo) {
    // Determinar nuevas opciones excluyendo las ya elegidas
    let otrospfid = []
    objetivo.siblings().not(':hidden').
      find('select[id$=proyectofinanciero_id]').each(() => {
        otrospfid.push(+this.value)
      })
    let idsel = objetivo.find('select').attr('id')
    resp.sort((a,b) => {
      if (a.nombre.toLowerCase() < b.nombre.toLowerCase()) {
        return -1
      } else if (a.nombre.toLowerCase() > a.nombre.toLowerCase()) {
        return 1
      } else {
        return 0
      }
    })

    let nuevasop = []
    resp.forEach((r) => {
      if (!otrospfid.includes(+r.id)) {
        nuevasop.push({'id': +r.id, 'nombre': r.nombre})
      }
    })
    Msip__Motor.remplazaOpcionesSelect(
      idsel, nuevasop, true, 'id', 'nombre', true
    )
    $('#' + idsel).val('')
    let el = document.querySelector('#' + idsel)
    Msip__Motor.configurarElementoTomSelect(el)
  }

  static actualizarActividadSelRango(resp, objetivo) {
    // Determinar nuevas opciones excluyendo las ya elegidas
    let otrospfid = []
    objetivo.siblings().not(':hidden').find('select').each(() => {
      otrospfid.push(+this.value)
    })
    let idsel = objetivo.find('select').attr('id')
    let valac = +$('#' + idsel).val()
    let valsel = 7
    let nuevasop = []
    resp.forEach((r) => {
      if (!otrospfid.includes(+r.id)) {
        nuevasop.push({'id': +r.id, 'nombre': r.nombre})
        if (r.id == valac) {
          valsel = valac
        }
      }
    })
    Msip__Motor.remplazaOpcionesSelect(
      idsel, nuevasop, true, 'id', 'nombre', false
    )
    $('#' + idsel).val(valsel)
    $('#' + idsel).trigger('chosen:updated')

  }


  // PERSONAS/BENEFICIARIOS

  // Actualiza campos dinámicos cuando hay caracterización
  static actualizarCamposDinamicos() {
    let ruta = document.location.pathname
    if (ruta.length == 0) {
      return
    }
    if (ruta.startsWith(window.puntoMontaje)) {
      ruta = ruta.substr(window.puntoMontaje.length)
    }
    if (ruta[0] == '/') {
      ruta = ruta.substr(1)
    }
    let pfids = $('#persona_proyectofinanciero_ids').val()

    if (pfids.length == 0) {
      pfids = [-1] // convencio vacio. Si se usa [] no llega al controlador
    }

    let params = {
      proyectofinanciero_ids: pfids
    }
    Msip__Motor.enviaAjaxDatosRutaYPinta(
      ruta, params, '#acordeon-caracterizacion', '#acordeon-caracterizacion'
    )
  }


  // Se ejecuta desde app/javascript/application.js tras importar el motor
  static iniciar() {
    console.log("* Corriendo Cor1440Gen__Motor::iniciar()")
  }

}
