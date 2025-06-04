# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require msip/motor
#//= require heb412_gen/motor
#//= require cocoon
#//= require cor1440_gen/proyectofinanciero
#//= require cor1440_gen/mindicadorespf
#//= require cor1440_gen/AutocompletaAjaxAsistentes

@DEP_OBJETIVOPF = [
    'select[id^=proyectofinanciero_resultadopf_attributes][id$=_objetivopf_id]',
    'select[id^=proyectofinanciero_indicadorobjetivo_attributes][id$=_objetivopf_id]'
  ]

@DEP_RESULTADOPF = [
     'select[id^=proyectofinanciero_indicadorpf_attributes][id$=_resultadopf_id]',
     'select[id^=proyectofinanciero_actividadpf_attributes][id$=_resultadopf_id]'
  ]

@DEP_INDICADORPF = []


# ACTIVIDAD
# TABLA DE RANGOS DE EDAD

# En tabla de rangos de edad cálcula total de una columna
# excluyendo eliminados
# Identifica la columna por el prefijo común ini y el posfijo común col
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


# Calcula población total sumando totales parciales por sexo y local/externo
cor1440_gen_rangoedadac_tot = () ->
  fl = parseInt($("#tactividadfl").text())
  fr = parseInt($("#tactividadfr").text())
  ml = parseInt($("#tactividadml").text())
  mr = parseInt($("#tactividadmr").text())
  sr = parseInt($("#tactividads").text())
  $("#tactividadtot").text(fl + fr + ml + mr + sr)
  return


# Calcula subtotal para una columna y después gran total
@cor1440_gen_rangoedadac = ($this) ->
  cid = $this.attr('id')
  if typeof cid != "undefined"
    n = cid.lastIndexOf('_')
    col = cid.slice(n+1)
    ini = cid.slice(0, cid.indexOf("attributes") + 10)
    cor1440_gen_rangoedadac_uno(ini, col)
    cor1440_gen_rangoedadac_tot()
  return


# Calcula totales para todas las columnas
cor1440_gen_rangoedadc_todos = () ->
  ini = 'actividad_actividad_rangoedadac_attributes'
  cor1440_gen_rangoedadac_uno(ini, 'fl')
  cor1440_gen_rangoedadac_uno(ini, 'fr')
  cor1440_gen_rangoedadac_uno(ini, 'ml')
  cor1440_gen_rangoedadac_uno(ini, 'mr')
  cor1440_gen_rangoedadac_uno(ini, 's')
  cor1440_gen_rangoedadac_tot()


# Llena idrf relacionando rangos de edad de base de datos con
# Filas de la tabla de rangos de edad
#
# resp Objeto JSON con rangosedadac, respuesta de llamada AJAX
# rangos Por llenar con rangos de edad
# idrf Por llenar con datos de tabla población (y reordenar tabla si se requiere)
@cor1440_gen_identifica_ids_rangoedad = (resp, rangos, idrf) ->
  # idrf[i] será id que rails le asignó al generar HTML a la fila
  # del rango de edad con id i en la tabla cor1440_gen_rangoedadac
  for i, r of resp
    rangos[r.id] = [r.limiteinferior, r.limitesuperior]
    idrf[r.id] = -1

  # Llena id de elemento en formulario en idrf y borra redundantes
  # de la tabla de población.
  $('select[id^=actividad_actividad_rangoedadac_attributes_][id$=_rangoedadac_id]').each((i, v) ->
    nr = +$(this).val()
    if idrf[nr] != -1 # Repetido, unir con el inicial
      fl2 = $(this).parent().parent().find('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_fl]').val()
      ml2 = $(this).parent().parent().find('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_ml]').val()
      sl2 = $(this).parent().parent().find('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_sl]').val()
      $(this).parent().parent().find('a.remove_fields').click()
      prl = '#actividad_actividad_rangoedadac_attributes_' + idrf[nr]
      fl1 = $(prl + '_fl').val()
      ml1 = $(prl + '_ml').val()
      sl1 = $(prl + '_sl').val()
      $(prl + '_fl').val(fl1 + fl2)
      $(prl + '_ml').val(ml1 + ml2)
      $(prl + '_sl').val(sl1 + sl2)
    else
      idrf[nr] = /actividad_actividad_rangoedadac_attributes_(.*)_rangoedadac_id/.exec($(this).attr('id'))[1]
  )


# Llamada asincronamente después de cor1440_gen_recalcula_poblacion
# con resultado de respuesta AJAX resp con rangos de edad
@cor1440_gen_recalcula_poblacion2 = (root, resp, fsig) ->
  # Identifica rangos de edad en base y en tabla resumiendo tabla si hace falta
  rangos = {}
  idrf = {}
  cor1440_gen_identifica_ids_rangoedad(resp, rangos, idrf)

  # Fecha de la actividad
  arf = msip_partes_fecha_localizada($('#actividad_fecha').val(), window.formato_fecha)
  anioref  = arf[0]
  mesref  = arf[1]
  diaref  = arf[2]

  # Recorre listado de personas
  $('[id^=actividad_asistencia_attributes][id$=_persona_attributes_anionac]').each((i, v) ->
    # excluye eliminadas
    if $(this).parent().parent().parent().css('display') != 'none'
      ida = /actividad_asistencia_attributes_(.*)_persona_attributes_anionac/.exec($(this).attr('id'))[1]
      anionac = $(this).val()
      mesnac = $('[id=actividad_asistencia_attributes_' + ida + '_persona_attributes_mesnac]').val()
      dianac = $('[id=actividad_asistencia_attributes_' + ida + '_persona_attributes_dianac]').val()

      e = +msip_edadDeFechaNacFechaRef(anionac, mesnac, dianac, anioref, mesref, diaref)
      idran = -1  # id del rango en el que está e
      ransin = -1 # id del rango SIN INFORMACION
      #debugger
      for i, r of rangos
        if (r[0] <= e || r[0] == '' || r[0]  == null) && (e <= r[1] || r[1] == '' || r[1] == null)
          idran = i
  #          if idrf[i] == -1
  #            cor1440_gen_aumenta_fila_poblacion(idrf, i)
        else if r[0] == -1
          ransin = i
      if idran == -1
        idran = ransin
      sexo = $(this).parent().parent().parent().find('[id^=actividad_asistencia_attributes][id$=_persona_attributes_sexo]:visible').val()
      if idran < 0
        alert('No pudo ponerse en un rango de edad')
      else
        cor1440_gen_aumenta_poblacion(idrf, sexo, idran, 1)
  )

  if fsig != null
    fsig(rangos, idrf)


# Hace petición AJAX para recalcular tabla poblacion en actividad
# a partir de listado de personas beneficiarias  y de casos
# beneficiarios
# fsig es función que llamará después de completar con registro con
#   datos que ha calculado como rangos e idrf
@cor1440_gen_recalcula_poblacion = (fsig = null) ->
  if $('[id^=actividad_asistencia_attributes]:visible').length > 0  || $('#actividad_casosjr').find('tr:visible').length > 0
    # No permitiria añadir manualmente a población
    # $('a[data-association-insertion-node$=actividad_rangoedadac]').hide()
    # Pone en blanco las cantidades y deshabilita edición
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_fr]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', true);
     )
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_mr]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', true);
    )
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_s]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', true);
    )
  else
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_fr]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', false);
    )
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_mr]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', false);
    )
    $('input[id^=actividad_actividad_rangoedadac_attributes_][id$=_s]').each((i, v) ->
      $(this).val(0)
      $(this).prop('readonly', false);
    )

  msip_funcion_1p_tras_AJAX('admin/rangosedadac.json?filtro[bushabilitado]=Si&filtrar=Filtrar', {}, cor1440_gen_recalcula_poblacion2, fsig, 'solicitando rangos de edad a servidor')



# Recalcula tabla poblacion en actividad a partir de listado de
# asistencia (método 2 con
# llamada AJAX para recuperar información de rangos de edad)
@cor1440_gen_super_recalcula_poblacion = () ->
  cor1440_gen_recalcula_poblacion(null)

# Aumenta una fila a tabla de población y completa idrf
# Será fila que tendrá rango con id idrango
# @param idrf relaciona identificaciones en base con identificaciones
#   en página HTML
@cor1440_gen_aumenta_fila_poblacion = (idrf, idrango) ->
  # Agregar rango y actualizar idrf
  $('a[data-association-insertion-node$=actividad_rangoedadac]').click()
  uf = $('#actividad_rangoedadac').children().last()
  if uf.length > 0 
    e = uf.find('[id^=actividad_actividad_rangoedadac_attributes][id$=_rangoedadac_id]')
    idrf[idrango] = /actividad_actividad_rangoedadac_attributes_(.*)_rangoedadac_id/.exec(e.attr('id'))[1]
    $('select[id^=actividad_actividad_rangoedadac_attributes_' + idrf[idrango] + '_rangoedadac_id]').val(idrango)



# Aumenta valor en tabla población para el sexo y rango de edad
# dado en la cantidad dada
@cor1440_gen_aumenta_poblacion = (idrf, sexo, idran, cantidad) ->
  if +cantidad == 0
    return
  if idrf[idran] == -1
    cor1440_gen_aumenta_fila_poblacion(idrf, idran)

  pref = '#actividad_actividad_rangoedadac_attributes_' + idrf[idran]
  if sexo == 'F'
    fr = +$(pref + '_fr').val()
    $(pref + '_fr').val(fr + (+cantidad))
    cor1440_gen_rangoedadac($(pref + '_fr'))
  else if sexo == 'M'
    mr = +$(pref + '_mr').val()
    $(pref + '_mr').val(mr + (+cantidad))
    cor1440_gen_rangoedadac($(pref + '_mr'))
  else
    sr = +$(pref + '_s').val()
    $(pref + '_s').val(sr + (+cantidad))
    cor1440_gen_rangoedadac($(pref + '_s'))
  $('#actividad_rangoedadac').find('input[id^=actividad_actividad_rangoedadac_attributes]').each () ->
    if +$(this).val() == 0
      cor1440_gen_rangoedadac($(this))





@cor1440_gen_fun_etiqueta_resultadopf = (jv) ->
   et = jv.find('select[id$=_objetivopf_id] option[selected]').text() +
    jv.find('input[id$=_numero]').val()
   return et

@cor1440_gen_actualiza_objetivos = (e, objetivo) ->
  msip_actualiza_cuadros_seleccion_dependientes('objetivospf',
    '_id', '_numero', DEP_OBJETIVOPF, 'id', 'numero')
  msip_actualiza_cuadros_seleccion_dependientes_fun_etiqueta(
    'resultadospf', '_id', cor1440_gen_fun_etiqueta_resultadopf,
    DEP_RESULTADOPF, 'id', 'numero')


@cor1440_gen_actualiza_resultados = (e, resultado) ->
  msip_actualiza_cuadros_seleccion_dependientes_fun_etiqueta(
    'resultadospf', '_id', cor1440_gen_fun_etiqueta_resultadopf,
    DEP_RESULTADOPF, 'id', 'numero')


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
  msip_envia_ajax_datos_ruta_y_pinta(ruta, params,
    '#camposdinamicos', '#camposdinamicos')

@cor1440_gen_llena_actividadpf_relacionadas = (root, res) ->
  ac_relacionadas = res.ac_ids_relacionadas
  val_actuales = []
  if ac_relacionadas.length > 0
    $('#actividad_proyectofinanciero tr').not(':hidden').each(() ->
      val_actuales = $(this).find('select[id$=actividadpf_ids]').val()
      if val_actuales.length > 0
        ac_relacionadas = ac_relacionadas.concat(val_actuales)
    )
    $('#actividad_proyectofinanciero tr').not(':hidden').each(() ->
      $(this).find('select[id$=actividadpf_ids]').val(ac_relacionadas)
      $(this).find('select[id$=actividadpf_ids]').each((el) ->
        Msip__Motor.configurarElementoTomSelect(el)
      )
    )

@cor1440_gen_actividad_actualiza_mismotipo = (root, res) ->
  if res.selected?
    acids = ['']
    $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_actividadpf_ids]').each( () ->
      t = $(this)
      if t.parent().parent().parent().not(':hidden').length > 0
        acids = acids.concat(t.val())
    )
    prids = []
    $('#actividad_proyectofinanciero tr').not(':hidden').each(() ->
      idex = $(this).find('select[id$=proyectofinanciero_id]').val()
      prids.push(idex)
    )
    params = {
      actividadpf_ids: acids,
      proyectofinanciero_ids: prids
    }
    msip_ajax_recibe_json(root, 'api/actividades/relacionadas',
      params, cor1440_gen_llena_actividadpf_relacionadas)



@cor1440_gen_llena_actividadpf_conancestros = (root, res) ->
  ac_conancestros = res.ac_ids_conancestros
  $('select[id^=actividad_actividad_proyectofinanciero_attributes][id$=actividadpf_ids]').each(() ->
    actuales = $(this).val()
    # ac_conancestros incluye los actuales
    posibles = []
    $(this).find('option').each(() ->
      posibles.push(+this.value)
    )
    int = posibles.filter( (v) -> ac_conancestros.includes(v))
    $(this).val(int)
    Msip__Motor.configurarElementoTomSelect(this)
    if int.length != actuales.length
      $(this).trigger('cor1440_gen:conancestros_actualizado')
  )


@cor1440_gen_actividad_actualiza_conancestros = (root, res) ->
  if res.selected?
    acids = ['']
    $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_actividadpf_ids]').each( () ->
      t = $(this)
      if t.parent().parent().parent().not(':hidden').length > 0
        acids = acids.concat(t.val())
    )
    prids = []
    $('#actividad_proyectofinanciero tr').not(':hidden').each(() ->
      idex = $(this).find('select[id$=proyectofinanciero_id]').val()
      prids.push(idex)
    )
    params = {
      actividadpf_ids: acids,
      proyectofinanciero_ids: prids
    }
    msip_ajax_recibe_json(root, 'actividadespf/conancestros',
      params, cor1440_gen_llena_actividadpf_conancestros)


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
  msip_envia_ajax_datos_ruta_y_pinta(ruta, params,
    '#camposdinamicos', '#camposdinamicos')

@cor1440_gen_actividad_actualiza_actividadpf_pf =  (root, proyectofinanciero_id) ->
  params = {
    pfl: [proyectofinanciero_id]
  }
  msip_llena_select_con_AJAX2('actividadespf', params,
    'actividad_actividadpf_ids', 'con Actividades de convenio', root,
    'id', 'nombre', cor1440_gen_actividad_actualiza_camposdinamicos)


@cor1440_gen_actividad_actualiza_actividadpf =  (root) ->
  params = {
    pfl: $('#actividad_proyectofinanciero_ids').val(),
  }
  msip_llena_select_con_AJAX2('actividadespf', params,
    'actividad_actividadpf_ids', 'con Actividades de convenio', root,
    'id', 'nombre', cor1440_gen_actividad_actualiza_camposdinamicos)


@cor1440_gen_actividad_actualiza_pf = (root) ->
  params = {
    fecha: $('#actividad_fecha').val(),
  }
  msip_llena_select_con_AJAX2('proyectosfinancieros', params,
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
#    msip_llena_select_con_AJAX2('actividadespf', params,
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
    fecha: $('#actividad_fecha').val(),
  }
  msip_funcion_tras_AJAX('proyectosfinancieros', params,
    cor1440_gen_actividad_actualiza_pf2, 'con Convenios Financiados',
    root)

@cor1440_gen_actividad_actualiza_pf_op = (root, resp, objetivo) ->
  # Determinar nuevas opciones excluyendo las ya elegidas
  otrospfid = []
  objetivo.siblings().not(':hidden').find('select[id$=proyectofinanciero_id]').each(() ->
    otrospfid.push(+this.value)
  )
  idsel = objetivo.find('select').attr('id')
  resp.sort((a,b) -> 
    if a.nombre.toLowerCase() < b.nombre.toLowerCase() 
      return -1
    else if a.nombre.toLowerCase() > a.nombre.toLowerCase()
      return 1
    else
      return 0
  )

  nuevasop = []
  resp.forEach((r) ->
    if !otrospfid.includes(+r.id)
      nuevasop.push({'id': +r.id, 'nombre': r.nombre})
  )
  msip_remplaza_opciones_select(idsel, nuevasop, true, 'id', 'nombre', true)
  $('#' + idsel).val('')
  el = document.querySelector('#' + idsel)
  Msip__Motor.configurarElementoTomSelect(el)

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
  msip_remplaza_opciones_select(idsel, nuevasop, true, 'id', 'nombre', false)
  $('#' + idsel).val(valsel)
  $('#' + idsel).trigger('chosen:updated')

  return


# PERSONAS/BENEFICIARIOS

# Actualiza campos dinámicos cuando hay caracterización
@cor1440_gen_persona_actualiza_camposdinamicos = (root) ->
  ruta = document.location.pathname
  if ruta.length == 0
    return
  if ruta.startsWith(root.puntomontaje)
    ruta = ruta.substr(root.puntomontaje.length)
  if ruta[0] == '/'
    ruta = ruta.substr(1)
  pfids = $('#persona_proyectofinanciero_ids').val()

  if pfids.length == 0
    pfids = [-1] # convencio vacio. Si se usa [] no llega al controlador


  params = {
    proyectofinanciero_ids: pfids
  }
  msip_envia_ajax_datos_ruta_y_pinta(ruta, params,
    '#acordeon-caracterizacion', '#acordeon-caracterizacion')


@cor1440_gen_instala_recalcula_poblacion = () ->
  # En actividad si se cambia sexo de un asistente
  #recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_sexo]:visible', (e) ->
    if (typeof cor1440_gen_recalcula_poblacion == 'function')
      cor1440_gen_recalcula_poblacion();
  )

  # En actividad si se cambia anio de nacimiento de un asistente
  # recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_anionac]:visible', (e) ->
    if (typeof cor1440_gen_recalcula_poblacion == 'function')
      cor1440_gen_recalcula_poblacion();
  )

  # En actividad si se cambia mes de nacimiento de un asistente
  # recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_mesnac]:visible', (e) ->
    if (typeof cor1440_gen_recalcula_poblacion == 'function')
      cor1440_gen_recalcula_poblacion();
  )

  # En actividad si se cambia dia de nacimiento de un asistente
  # recalcula tabla de población
  $(document).on('change', '[id^=actividad_asistencia_attributes][id$=_persona_attributes_dianac]:visible', (e) ->
    if (typeof cor1440_gen_recalcula_poblacion == 'function')
      cor1440_gen_recalcula_poblacion();
  )


  # En actividad tras eliminar asistencia recalcular población
  $('#asistencia').on('cocoon:after-remove', (e, papa) ->
    if (typeof cor1440_gen_recalcula_poblacion == 'function')
      cor1440_gen_recalcula_poblacion();
  )

  # Tras autocompletar asistente
  $(document).on('cor1440gen:autocompletado-asistente', (e, papa) ->
    if (typeof cor1440_gen_recalcula_poblacion == 'function')
      cor1440_gen_recalcula_poblacion();
  )


@cor1440_gen_prepara_eventos_comunes = (root, opciones = {}) ->

  @cor1440_gen_preparamindicadorespf(root)

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
    $('#actividad_fecha').on('change', (ev) ->
      cor1440_gen_actividad_actualiza_fecha2(root)
    )

    # Tras añadir una fila a la tabla de proyectosfinancieros y sus
    # actividadespf, se deja proyecto en blanco y se permite elegir uno de
    # entre los vigentes pero excluyendos los que ya estuvieran
    # (para evitar filas repetidas)
    $(document).on('cocoon:after-insert', '#actividad_proyectofinanciero', (e, objetivo) ->
      Msip__Motor.configurarElementosTomSelect()
      window.Msip__Motor.configurarElementosTomSelect()
      params = {
        fecha: $('#actividad_fecha').val(),
      }
      if $('#actividad_grupo_ids').length > 0
        params['grupo_ids'] = $('#actividad_grupo_ids').val()

      msip_funcion_1p_tras_AJAX('proyectosfinancieros', params,
        cor1440_gen_actividad_actualiza_pf_op, objetivo,
        'con Convenios Financiados', root)
    )

    $(document).on('cocoon:after-insert', '#actividad_rangoedadac', (e, objetivo) ->
      # Si se ha deshabilitado, no operar pero volver a habilitar
      params = {}
      msip_funcion_1p_tras_AJAX('admin/rangosedadac', params,
        cor1440_gen_actividad_actualiza_sel_rango, objetivo,
        'con Rangos de edad', root)
    )

    $(document).on('change', 'select[id^=actividad_actividad_rangoedadac_attributes_][id$=rangoedadac_id]', (e, res) ->
      $(e.target).attr('disabled', true)
      Msip__Motor.configurarElementoTomSelect(e.target)
    )

    # Al eliminar una fila de la tabla
    # se retiran subformularios de actividades de convenio
    $(document).on('cocoon:after-remove', '#actividad_proyectofinanciero', (e, objetivo) ->
      cor1440_gen_actividad_actualiza_camposdinamicos2(root)
    )

    # Al establecer un proyectofinanciero se deshabilita
    # posibilidad de edición al mismo y en la celda de actividades
    # de convenio se permite elegir entre las del proyecto elegido
    $(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=proyectofinanciero_id]', (e, res) ->
      #El parametro res sería enviado por chosen pero no por tom-select
      
      # Deshabilitar edición y dejar disponibles actividades de convenio
      $(e.target).attr('disabled', true)
      # Como deshabilitamos un select, creamos un input con el mismo nombre y
      # valor para que al enviar el formulario no se pierda la información
      el = document.createElement('input')
      el.setAttribute('name', e.target.name)
      el.setAttribute('type', 'hidden')
      el.setAttribute('value', e.target.value)
      e.target.parentNode.append(el)
      Msip__Motor.configurarElementoTomSelect(e.target)
      idac = $(e.target).parent().parent().parent().find('select[id$=actividadpf_ids]').attr('id')
      params = { pfl: [+e.target.value]}
      msip_llena_select_con_AJAX2('actividadespf', params,
        idac, 'con Actividades de convenio ' + e.target.value, root,
        'id', 'nombre', null)
    )

    # Antes de enviar el formulario de actividad, habilitamos campos
    # proyectofinanciero, que se habían deshabilitado para simplificar
    # interacción por parte de usuario.
    $("form[id^=edit_actividad]").submit(() ->
      $('select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=_proyectofinanciero_id]').removeAttr('disabled')
      $('select[id^=actividad_actividad_rangoedadac_attributes_][id$=_rangoedadac_id]').removeAttr('disabled')
      $('select[id^=actividad_detallefinanciero_attributes_][id$=_convenioactividad]').removeAttr('disabled')

    );

    # Tras agregar o eliminar actividades de convenio a un convenio
    # agregare o eliminar subformularios asociados
    $(document).on('change', 'select[id^=actividad_actividad_proyectofinanciero_attributes_][id$=actividadpf_ids]', (e, res) ->
      if typeof root.cor1440_gen_activa_autocompleta_mismotipo != 'undefined' && root.cor1440_gen_activa_autocompleta_mismotipo == true
        cor1440_gen_actividad_actualiza_mismotipo(root, res)
      if typeof root.cor1440_gen_activa_autocompleta_conancestros != 'undefined' && root.cor1440_gen_activa_autocompleta_conancestros == true
        cor1440_gen_actividad_actualiza_conancestros(root, res)


      cor1440_gen_actividad_actualiza_camposdinamicos2(root)
    )

  $(document).on('change', '#objetivospf [id$=_numero]', cor1440_gen_actualiza_objetivos)

  $(document).on('cocoon:after-remove', '#objetivospf', cor1440_gen_actualiza_objetivos)

  $(document).on('cocoon:after-insert', '#objetivospf', cor1440_gen_actualiza_objetivos)

  $(document).on('cocoon:before-remove', '#objetivospf', (e, objetivo) ->
    return msip_intenta_eliminar_fila(objetivo, '/objetivospf/', DEP_OBJETIVOPF)
  )

  $(document).on('cocoon:before-remove', '#indicadoresobjetivos', (e, indicador) ->
    msip_intenta_eliminar_fila(indicador, '/indicadorespf/',
        DEP_INDICADORPF
    )
  )

  $(document).on('change', '#indicadoresobjetivos [id$=_id]', (e, result) ->
    msip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )

  $(document).on('cocoon:after-insert', '#indicadoresobjetivos',
    cor1440_gen_actualiza_objetivos)

  $(document).on('change', '#resultadospf [id$=_numero]', cor1440_gen_actualiza_resultados)

  $(document).on('cocoon:after-remove', '#resultadospf', cor1440_gen_actualiza_resultados)

  $(document).on('cocoon:after-insert', '#resultadospf', cor1440_gen_actualiza_objetivos)

  $(document).on('cocoon:before-remove', '#resultadospf', (e, resultado) ->
    msip_intenta_eliminar_fila(resultado, '/resultadospf/',
        DEP_RESULTADOPF
    )
  )

  $(document).on('change', '#resultadospf [id$=_id]', (e, result) ->
    msip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )


  $(document).on('cocoon:before-remove', '#indicadorespf', (e, indicador) ->
    msip_intenta_eliminar_fila(indicador, '/indicadorespf/',
        DEP_INDICADORPF
    )
  )

  $(document).on('change', '#indicadorespf [id$=_id]', (e, result) ->
    msip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )

  $(document).on('cocoon:after-insert', '#indicadorespf', cor1440_gen_actualiza_resultados)

  $(document).on('cocoon:after-insert', '#actividadespf', cor1440_gen_actualiza_resultados)
  $(document).on('change', '#actividadespf [id$=_id]', (e, result) ->
    msip_enviarautomatico_formulario($('form'), 'POST', 'json', false, 'Enviar')
  )


  # En listado de asistencia permite autocompletar nombres
  Cor1440GenAutocompletaAjaxAsistentes.iniciar()

  # En medición de indicadores, elegir convenio hace click
  $(document).on('change', '[data-enviar-haciendo-click]', (e, result) ->
    $('[name=' + $(this).data('enviar-haciendo-click') + ']').trigger('click')
  )

  $(document).on('cocoon:after-insert', '#pmindicadorpf', (e, objetivo) ->
    dids = $.map($('[name^=datosintermediosti]'), (e) => +e.value)
    cuenta = objetivo.parent().parent().find('input[name^=datosintermediosti]').length - 1
    idpm = +objetivo.find('input[id^=mindicadorpf_pmindicadorpf_attributes_][id$=_id]')[0].id.match(/mindicadorpf_pmindicadorpf_attributes_([0-9]*)_id/)[1]
    objetivo.parent().parent().find('input[name^=datosintermediosti]').each( (d) ->
      $(objetivo.children('td')[4]).before('<td> <div class="input float optional mindicadorpf_pmindicadorpf_datointermedioti_pmindicadorpf_valor"><input class="numeric float optional form-control span10" type="number" step="any" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][valor]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_valor" style="background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);"></div><div class="input hidden mindicadorpf_pmindicadorpf_datointermedioti_pmindicadorpf_rutaevidencia"><input class="hidden form-control span10" type="hidden" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][rutaevidencia]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_rutaevidencia" style="background-color: rgb(255, 255, 255); color: rgb(0, 0, 0);"></div><input class="hidden form-control span10" type="hidden" value="' + dids[cuenta] + '" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][datointermedioti_id]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_datointermedioti_id"> <input class="hidden form-control span10" type="hidden" value="" name="mindicadorpf[pmindicadorpf_attributes][' + idpm + '][datointermedioti_pmindicadorpf_attributes][' + cuenta + '][id]" id="mindicadorpf_pmindicadorpf_attributes_' + idpm + '_datointermedioti_pmindicadorpf_attributes_' + cuenta + '_id"></td>')
      cuenta--
    )
  )


  # Beneficiarios
  # Campos dinámicos
  $(document).on('change', 'select[id=persona_proyectofinanciero_ids]', (e, res) ->
    cor1440_gen_persona_actualiza_camposdinamicos(root)
  )

  return

