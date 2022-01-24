
export default class Cor1440GenAutocompletaAjaxAsistentes {
  /* No usamos constructor ni this porque en operaElegida sería
   * del objeto AutocompletaAjaxExpreg y no esta clase.
   * Más bien en esta todo static
   */


  // Elije una persona en autocompletación
  static operarElegida (cadpersona, id, eorig) {
    let root = window
    sip_arregla_puntomontaje(root)
    const cs = id.split(';')
    const idPersona = cs[0]
    let d = '&id_persona=' + idPersona
    const a = root.puntomontaje + 'personas/datos'

    window.Rails.ajax({
      type: 'GET',
      url: a,
      data: d,
      success: (resp, estado, xhr) => {
        const divcp = eorig.target.closest('.' + Cor1440GenAutocompletaAjaxAsistentes.claseEnvoltura)
        divcp.querySelector('[id$=_attributes_id]').value = resp.id
        divcp.querySelector('[id$=_attributes_nombres]').value = resp.nombres
        divcp.querySelector('[id$=_attributes_apellidos]').value = resp.apellidos
        divcp.querySelector('[id$=_attributes_sexo]').value = resp.sexo
        const tdocid = divcp.querySelector('[id$=_attributes_tdocumento_id]')
        if (tdocid != null) {
          let idop = null
          tdocid.childNodes.forEach((o) => {
            if (typeof (o.innerText) === 'string' &&
              o.innerText === resp.tdocumento) {
              idop = o.value
            }
          })
          if (idop != null) {
            tdocid.value = idop
          }
        }
        const numdoc = divcp.querySelector('[id$=_numerodocumento]')
        if (numdoc != null) {
          numdoc.value = resp.numerodocumento
        }
        const anionac = divcp.querySelector('[id$=_anionac]')
        if (anionac != null) {
          anionac.value = resp.anionac
        }
        const mesnac = divcp.querySelector('[id$=_mesnac]')
        if (mesnac != null) {
          mesnac.value = resp.mesnac
        }
        const dianac = divcp.querySelector('[id$=_dianac]')
        if (dianac != null) {
          dianac.value = resp.dianac
        }
        const cargo = divcp.querySelector('[id$=_cargo]')
        if (cargo != null) {
          cargo.value = resp.cargo
        }
        const correo = divcp.querySelector('[id$=_correo]')
        if (correo != null) {
          correo.value = resp.correo
        }
        eorig.target.setAttribute('data-autocompleta', 'no')
        eorig.target.removeAttribute('list')
        const sel = document.getElementById(
          Cor1440GenAutocompletaAjaxAsistentes.idDatalist)
        sel.innerHTML = ''
        // $(document).trigger('cor1440gen:autocompletado-asistente')
        document.dispatchEvent(new Event('cor1440gen:autocompletado-asistente'))
      },
      error: (resp, estado, xhr) => {
        window.alert('Error con ajax ' + resp)
      }
    })
  }

  static iniciar() {
    console.log("AutocompletaAjaxAsistente cor1440")
    let url = window.puntomontaje + 'personas.json'
    var asistentes = new window.AutocompletaAjaxExpreg(
      [/^actividad_asistencia_attributes_[0-9]*_persona_attributes_nombres$/],
      url,
      Cor1440GenAutocompletaAjaxAsistentes.idDatalist,
      Cor1440GenAutocompletaAjaxAsistentes.operarElegida
    )
    asistentes.iniciar()
  }

}

// Queriamos hacer dentro de Cor1440GenAutocompletaAjaxAsistentes static claseEnvoltura = 'campos_asistente' pero la versión de bable usada por babel-transpiler, usado por sprockets4 no lo soporta así que:
Cor1440GenAutocompletaAjaxAsistentes.claseEnvoltura = 'nested-fields'
Cor1440GenAutocompletaAjaxAsistentes.idDatalist = 'fuente-asistentes'
