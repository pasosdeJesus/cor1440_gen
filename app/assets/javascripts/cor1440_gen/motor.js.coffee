# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require sip/motor
#//= require heb412_gen/motor
#//= require cocoon

@DEP_OBJETIVOPF = [
    'select[id^=proyectofinanciero_resultadopf_attributes][id$=_objetivopf_id]',
    'select[id^=proyectofinanciero_indicadorobjetivo_attributes][id$=_objetivopf_id]'
  ]

@DEP_RESULTADOPF = [
     'select[id^=proyectofinanciero_indicadorpf_attributes][id$=_resultadopf_id]',
     'select[id^=proyectofinanciero_actividadpf_attributes][id$=_resultadopf_id]'
  ]
 
@DEP_INDICADORPF = []

cor1440_gen_rangoedadac_uno = (ini, col) ->
  sumc = 0
  $('[id^='+ini+'][id$='+col+']').each( (o) ->
    v = $(this).val()
    if (v != "")
      ab = $(this).parent().parent().css('display')
      if (ab != 'none') 
        sumc += parseInt(v)
  )
  $("#tactividad" + col).text(sumc)
  return

cor1440_gen_rangoedadac_tot = () ->
  fl = parseInt($("#tactividadfl").text())
  fr = parseInt($("#tactividadfr").text())
  ml = parseInt($("#tactividadml").text())
  mr = parseInt($("#tactividadmr").text())
  sr = parseInt($("#tactividads").text())
  $("#tactividadtot").text(fl + fr + ml + mr + sr)
  return

@cor1440_gen_rangoedadac = ($this) ->
  cid = $this.attr('id')
  n = cid.lastIndexOf('_')
  col = cid.slice(n+1)
  ini = cid.slice(0, cid.indexOf("attributes") + 10)
  cor1440_gen_rangoedadac_uno(ini, col)
  cor1440_gen_rangoedadac_tot()
  return

cor1440_gen_rangoedadc_todos = () ->
  ini = 'actividad_actividad_rangoedadac_attributes'
  cor1440_gen_rangoedadac_uno(ini, 'fl')
  cor1440_gen_rangoedadac_uno(ini, 'fr')
  cor1440_gen_rangoedadac_uno(ini, 'ml')
  cor1440_gen_rangoedadac_uno(ini, 'mr')
  cor1440_gen_rangoedadac_uno(ini, 's')
  cor1440_gen_rangoedadac_tot()

@cor1440_gen_actualiza_objetivos = (e, objetivo) ->
  sip_actualiza_cuadros_seleccion_dependientes('objetivospf', 
    '_id', '_numero', DEP_OBJETIVOPF, 'id', 'numero')

@cor1440_gen_actualiza_resultados = (e, resultado) ->
    sip_actualiza_cuadros_seleccion_dependientes('resultadospf', 
        '_id', '_numero', DEP_RESULTADOPF, 'id', 'numero')

# En formulario actividad

# Actualiza campos dinámicos cuando hay un solo campo de actividades de proyectofinanciero
@cor1440_gen_actividad_actualiza_camposdinamicos = (root) ->
  ruta = document.location.pathname
  if ruta.length == 0
    return
  if ruta.startsWith(root.puntomontaje)
    ruta = ruta.substr(root.puntomontaje.length)
  if ruta[0] == '/'
    ruta = ruta.substr(1)
  params = {
    actividadpf_ids: $('#actividad_actividadpf_ids').val()
  }
  sip_envia_ajax_datos_ruta_y_pinta(ruta, params,
    '#camposdinamicos', '#camposdinamicos')


# Actualiza campos dinámicos cuando hay una tabla de proyectofinanciero
# y actividades de proyectofinanciero
@cor1440_gen_actividad_actualiza_camposdinamicos2 = (root) ->
  ruta = document.location.pathname
  if ruta.length == 0
    return
  if ruta.startsWith(root.puntomontaje)
    ruta = ruta.substr(root.puntomontaje.length)
  if ruta[0] == '/'
    ruta = ruta.substr(1)
  acids = ['']
  $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_actividadpf_ids]').each( () -> 
    t = $(this)
    if t.parent().parent().parent().not(':hidden').length > 0
      acids = acids.concat(t.val())
  )

  params = {
    actividadpf_ids: acids
  }
  sip_envia_ajax_datos_ruta_y_pinta(ruta, params,
    '#camposdinamicos', '#camposdinamicos')

@cor1440_gen_actividad_actualiza_actividadpf_pf =  (root, proyectofinanciero_id) ->
  params = {
    pfl: [proyectofinanciero_id]
  }
  sip_llena_select_con_AJAX2('actividadespf', params, 
    'actividad_actividadpf_ids', 'con Actividades de convenio', root,
    'id', 'nombre', cor1440_gen_actividad_actualiza_camposdinamicos)


@cor1440_gen_actividad_actualiza_actividadpf =  (root) ->
  params = {
    pfl: $('#actividad_proyectofinanciero_ids').val(),
  }
  sip_llena_select_con_AJAX2('actividadespf', params, 
    'actividad_actividadpf_ids', 'con Actividades de convenio', root,
    'id', 'nombre', cor1440_gen_actividad_actualiza_camposdinamicos)


@cor1440_gen_actividad_actualiza_pf = (root) ->
  params = {
    fecha: $('#actividad_fecha_localizada').val(),
  }
  sip_llena_select_con_AJAX2('proyectosfinancieros', params,
    'actividad_proyectofinanciero_ids', 'con Convenios financiados',
    root, 'id', 'nombre',
    cor1440_gen_actividad_actualiza_actividadpf)


@cor1440_gen_actividad_actualiza_pf2 =  (root, pfpend = null) ->
  # Si hay listado de proyectos vigentes, limitar a esos
  if pfpend != null
    pfpendid = pfpend.map((e) => (e.id))
    pfex = []
    $('#actividad_proyectofinanciero tr').not(':hidden').each(() -> 
      idex = $(this).find('select[id$=proyectofinanciero_id]').val()
      if !(pfpendid.includes(+idex))
        $(this).remove()
    )
  # Actualizar campos dinámicos
  cor1440_gen_actividad_actualiza_camposdinamicos2(root)

#  porac = []
#  $('#actividad_proyectofinanciero tr').not(':hidden').each(() -> 
#      porac.push({
#        npf: $(this).find('select[id$=proyectofinanciero_id]').val(),
#        idac: $(this).find('select[id$=actividadpf_ids]').attr('id') 
#      })
#  )
#
#  debugger
#  # Llenar los select de actividades de convenio y tras de el último
#  # actualizar campos dinámicos --dando tiempo a los ajax de terminar
#  n = 0
#  porac.forEach((r) ->
#    params = { pfl: [r.npf] }
#    f = null
#    if n == r.length -1
#    sip_llena_select_con_AJAX2('actividadespf', params, 
#        r.idac, 'con Actividades de convenio ' + r.npf, root,
#        'id', 'nombre', f)
#    n += 1
#  )

@cor1440_gen_actividad_limita_pf_actualiza_actividadpf =  (root, pfpend = null) ->
  # Si hay listado de proyectos vigentes, limitar a esos
  if pfpend != null
    pfpendid = pfpend.map((e) => (e.id))
    pfex = []
    $('#actividad_proyectofinanciero tr').not(':hidden').each(() -> 
      idex = $(this).find('select[id$=proyectofinanciero_id]').val()
      if !(pfpendid.includes(+idex))
        $(this).remove()
    )
 
@cor1440_gen_actividad_actualiza_fecha2 = (root) ->
  params = {
    fecha: $('#actividad_fecha_localizada').val(),
  }
  sip_funcion_tras_AJAX('proyectosfinancieros', params, 
    cor1440_gen_actividad_actualiza_pf2, 'con Convenios Financiados', 
    root)

@cor1440_gen_actividad_actualiza_pf_op = (root, resp, objetivo) ->
  # Determinar nuevas opciones excluyendo las ya elegidas
  otrospfid = []
  objetivo.siblings().not(':hidden').find('select').each(() -> 
    otrospfid.push(+this.value)
  )
  idsel = objetivo.find('select').attr('id')
  nuevasop = []
  resp.forEach((r) -> 
    if !otrospfid.includes(+r.id)
      nuevasop.push({'id': +r.id, 'nombre': r.nombre})
  )
  sip_remplaza_opciones_select(idsel, nuevasop, true, 'id', 'nombre', true)
  $('#' + idsel).val('')
  $('#' + idsel).trigger('chosen:updated')

  return

@cor1440_gen_actividad_actualiza_sel_rango = (root, resp, objetivo) ->
  # Determinar nuevas opciones excluyendo las ya elegidas
  otrospfid = []
  objetivo.siblings().not(':hidden').find('select').each(() -> 
    otrospfid.push(+this.value)
  )
  idsel = objetivo.find('select').attr('id')
  valac = +$('#' + idsel).val()
  valsel = 7
  nuevasop = []
  resp.forEach((r) -> 
    if !otrospfid.includes(+r.id)
      nuevasop.push({'id': +r.id, 'nombre': r.nombre})
      if r.id == valac
        valsel = valac
  )
  sip_remplaza_opciones_select(idsel, nuevasop, true, 'id', 'nombre', false)
  $('#' + idsel).val(valsel)
  $('#' + idsel).trigger('chosen:updated')

  return

# Elije un asistente en autocompletación
# Tras autocompletar disprar el evento cor1440gen:autocompletado-asistente
@cor1440_gen_autocompleta_asistente = (label, id, divcp, root) ->
  sip_arregla_puntomontaje(root)
  cs = id.split(";")
  id_persona = cs[0]
  pl = []
  ini = 0
  for i in [0..cs.length] by 1
     t = parseInt(cs[i])
     pl[i] = label.substring(ini, ini + t)
     ini = ini + t + 1
  # pl[1] cnom, pl[2] es cape, pl[3] es cdoc
  d = "&id_persona=" + id_persona
  a = root.puntomontaje + 'personas/datos'
  $.ajax(url: a, data: d, dataType: "json").fail( (jqXHR, texto) ->
    alert("Error con ajax " + texto)
  ).done( (e, r) ->
    #debugger
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_id]').val(e.id)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_nombres]').val(e.nombres)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_apellidos]').val(e.apellidos)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_sexo]').val(e.sexo)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_tdocumento]').val(e.tdocumento)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_numerodocumento]').val(e.numerodocumento)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_anionac]').val(e.anionac)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_mesnac]').val(e.mesnac)
    divcp.find('[id^=actividad_asistencia_attributes][id$=persona_attributes_dianac]').val(e.dianac)
    #if typeof jrs_recalcula_poblacion == 'function'
    #  jrs_recalcula_poblacion()
    $(document).trigger("cor1440gen:autocompletado-asistente")
    return
  )
  return

# Busca persona por nombre, apellido o identificación
# s es objeto con foco donde se busca persona
@cor1440_gen_busca_asistente = (s) ->
  root = window
  sip_arregla_puntomontaje(root)
  cnom = s.attr('id')
  v = $("#" + cnom).data('autocompleta')
  if (v != 1 && v != "no") 
    $("#" + cnom).data('autocompleta', 1)
    divcp = s.closest('.nested-fields')
    if (typeof divcp == 'undefined')
      alert('No se ubico .nested-fields')
      return
    idaa = divcp.parent().find('.actividad_asistencia_id').find('input').val()
    if (typeof idaa == 'undefined')
      alert('No se ubico actividad_asistencia_id')
      return
    $("#" + cnom).autocomplete({
      source: root.puntomontaje + "personas.json",
      minLength: 2,
      select: ( event, ui ) -> 
        if (ui.item) 
          cor1440_gen_autocompleta_asistente(ui.item.value, ui.item.id, divcp, root)
          event.stopPropagation()
          event.preventDefault()
    })
  return

# Medicion de indicadores

@cor1440_gen_llena_medicion = (root, res) ->
  hid = res.hmindicadorpf_id
  $('[id$=_' + hid + '_fecha_localizada]').val(res.fechaloc)
  $('[id$=_' + hid + '_dmed1]').val(res.dmed1)
  $('[id$=_' + hid + '_urlev1]').val(res.urlev1)
  $('[id$=_' + hid + '_dmed2]').val(res.dmed2)
  $('[id$=_' + hid + '_urlev2]').val(res.urlev2)
  $('[id$=_' + hid + '_dmed3]').val(res.dmed3)
  $('[id$=_' + hid + '_urlev3]').val(res.urlev3)
  $('[id$=_' + hid + '_rind]').val(res.rind)
  $('[id$=_' + hid + '_urlevrind]').val(res.urlevrind)
  meta = +$('[id$=_' + hid + '_meta]').val()
  if ( meta > 0)
    $('[id$=_' + hid + '_porcump]').val(res.rind*100/meta)


@cor1440_gen_calcula_pmindicador = (elem, event) ->
  event.stopPropagation() 
  event.preventDefault() 
  root =  window
  r = $(elem).closest('tr')
  efinicio = r.find('[id$=finicio_localizada]')
  hid = efinicio.attr('id').replace(/.*_attributes_([0-9]*)_finicio_localizada/, '$1');
  datos = {
    finicio_localizada: efinicio.val()
    ffin_localizada: r.find('[id$=ffin_localizada]').val()
    indicadorpf_id: $(document).find('#mindicadorpf_indicadorpf_id').val()
    hmindicadorpf_id: hid
  }
  sip_ajax_recibe_json(root, 'api/cor1440gen/mideindicador', 
    datos, cor1440_gen_llena_medicion)  
  return


@cor1440_gen_prepara_eventos_comunes = (root, opciones = {}) ->
  $(document).on('click', '.envia_filtrar', (e) -> 
    f = e.target.form
    a = f.action
    if a.endsWith(".pdf")
      $(f).attr("action", a.substr(0, a.length-4))
      $(f).removeAttr("target")
  )
  $(document).on('click', '.envia_generar_pdf', (e) -> 
    f = e.target.form
    a = f.action
    if !a.endsWith(".pdf")
      $(f).attr("action", a + ".pdf")
      $(f).attr("target", "_blank")
  )
  $(document).on('change', 'input[id^=actividad_actividad_rangoedadac_attributes]', (e) -> 
    cor1440_gen_rangoedadac($(this))
  )
  $(document).on('cocoon:after-remove', (e) -> 
    cor1440_gen_rangoedadc_todos();
  )

  if (!opciones['sin_eventos_cambia_proyecto'])
    $('#actividad_fecha_localizada').on('change', (ev) ->
      cor1440_gen_actividad_actualiza_fecha2(root)
    )
    $('#actividad_fecha_localizada').datepicker({
      format: root.formato_fecha,
      autoclose: true,
      todayHighlight: true,
      language: 'es'
    }).on('changeDate', (ev) ->
      cor1440_gen_actividad_actualiza_fecha2(root)
    )
#    $("#actividad_proyectofinanciero_ids").chosen().change( (e) ->
#      cor1440_gen_actividad_actualiza_actividadpf(root, null)
#    )
#    $('#actividad_actividadpf_ids').chosen().change( (e) ->
#      cor1440_gen_actividad_actualiza_camposdinamicos(root)
#    )
    
    # Tras añadir una fila a la tabla de proyectosfinancieros y sus 
    # actividadespf, se deja proyecto en blanco y se permite elegir uno de
    # entre los vigentes pero excluyendos los que ya estuvierna 
    # (para evitar filas repetidas)
    $(document).on('cocoon:after-insert', '#actividad_proyectofinanciero', (e, objetivo) ->
 
      $('.chosen-select').chosen()
      params = {
        fecha: $('#actividad_fecha_localizada').val(),
      }
      sip_funcion_1p_tras_AJAX('proyectosfinancieros', params, 
        cor1440_gen_actividad_actualiza_pf_op, objetivo, 
        'con Convenios Financiados', root)
    )

    $(document).on('cocoon:after-insert', '#actividad_rangoedadac', (e, objetivo) ->
      # Si se ha deshabilitado, no operar pero volver a habilitar
      params = {}
      sip_funcion_1p_tras_AJAX('admin/rangosedadac', params, 
        cor1440_gen_actividad_actualiza_sel_rango, objetivo, 
        'con Rangos de edad', root)
    )

    # Al eliminar una fila de la tabla
    # se retiran subformularios de actividades de convenio
    $(document).on('cocoon:after-remove', '#actividad_proyectofinanciero', (e, objetivo) ->
      cor1440_gen_actividad_actualiza_camposdinamicos2(root)
    )

    # Al establecer un proyectofinanciero se deshabilita 
    # posibilidad de edición al mismo y en la celda de actividades
    # de convenio se permite eleir entre las del proyecto elegido
    $(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=proyectofinanciero_id]', (e, res) ->
      # Deshabilitar edición y dejar disponibles actividades de convenio
      $(e.target).attr('disabled', true)
      $(e.target).trigger('chosen:updated')
      idac = $(e.target).parent().parent().parent().find('select[id$=actividadpf_ids]').attr('id')
      params = { pfl: [+res.selected]}
      sip_llena_select_con_AJAX2('actividadespf', params, 
        idac, 'con Actividades de convenio ' + res.selected, root,
        'id', 'nombre', null)
    )

    # Antes de enviar el formulario de actividad, habilitamos campos 
    # proyectofinanciero, que se habían deshabilitado para simplificar
    # interacción por parte de usuario.
    $("form[id^=edit_actividad]").submit(() ->
      $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_proyectofinanciero_id]').removeAttr('disabled')
    );
    
    # Tras agregar o eliminar actividades de convenio a un convenio
    # agregare o eliminar subformularios asociados
    $(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=actividadpf_ids]', (e, res) ->
      cor1440_gen_actividad_actualiza_camposdinamicos2(root)
    )
 
  $(document).on('change', '#objetivospf [id$=_numero]', cor1440_gen_actualiza_objetivos)
  
  $(document).on('cocoon:after-remove', '#objetivospf', cor1440_gen_actualiza_objetivos)
  
  $(document).on('cocoon:after-insert', '#objetivospf', cor1440_gen_actualiza_objetivos)
  
  $(document).on('cocoon:before-remove', '#objetivospf', (e, objetivo) ->
    return sip_intenta_eliminar_fila(objetivo, '/objetivospf/', DEP_OBJETIVOPF)
  )

  $(document).on('cocoon:before-remove', '#indicadoresobjetivos', (e, indicador) ->
    sip_intenta_eliminar_fila(indicador, '/indicadorespf/', 
        DEP_INDICADORPF
    )
  )
  
  $(document).on('change', '#indicadoresobjetivos [id$=_id]', (e, result) ->
    sip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )
  
  $(document).on('cocoon:after-insert', '#indicadoresobjetivos', 
    cor1440_gen_actualiza_objetivos)

  $(document).on('change', '#resultadospf [id$=_numero]', cor1440_gen_actualiza_resultados)
  
  $(document).on('cocoon:after-remove', '#resultadospf', cor1440_gen_actualiza_resultados)
  
  $(document).on('cocoon:after-insert', '#resultadospf', cor1440_gen_actualiza_objetivos)
  
  $(document).on('cocoon:before-remove', '#resultadospf', (e, resultado) ->
    sip_intenta_eliminar_fila(resultado, '/resultadospf/', 
        DEP_RESULTADOPF
    )
  )
  
  $(document).on('change', '#resultadospf [id$=_id]', (e, result) ->
    sip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )
  
  
  $(document).on('cocoon:before-remove', '#indicadorespf', (e, indicador) ->
    sip_intenta_eliminar_fila(indicador, '/indicadorespf/', 
        DEP_INDICADORPF
    )
  )
  
  $(document).on('change', '#indicadorespf [id$=_id]', (e, result) ->
    sip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )
  
  $(document).on('cocoon:after-insert', '#indicadorespf', cor1440_gen_actualiza_resultados)

  $(document).on('cocoon:after-insert', '#actividadespf', cor1440_gen_actualiza_resultados)
  $(document).on('change', '#actividadespf [id$=_id]', (e, result) ->
    sip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )
 
  # En listado de asistencia permite autocompletar nombres
  $(document).on('focusin', 
  'input[id^=actividad_asistencia_attributes_][id$=_persona_attributes_nombres]', 
  (e) ->
    cor1440_gen_busca_asistente($(this))
  )

