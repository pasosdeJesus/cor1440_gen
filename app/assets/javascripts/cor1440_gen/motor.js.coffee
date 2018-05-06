# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require sip/motor
#//= require heb412_gen/motor
#//= require jquery-ui/widgets/autocomplete
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
  $("#tactividadtot").text(fl + fr + ml + mr)
  return

cor1440_gen_rangoedadac = ($this) ->
  cid = $this.attr('id')
  col = cid.substr(-2)
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
  cor1440_gen_rangoedadac_tot()

@cor1440_gen_actualiza_objetivos = (e, objetivo) ->
  sip_actualiza_cuadros_seleccion_dependientes('objetivospf', 
    '_id', '_numero', DEP_OBJETIVOPF, 'id', 'numero')

@cor1440_gen_actualiza_resultados = (e, resultado) ->
    sip_actualiza_cuadros_seleccion_dependientes('resultadospf', 
        '_id', '_numero', DEP_RESULTADOPF, 'id', 'numero')

# En formulario actividad
@cor1440_gen_actividad_actualiza_actividadpf =  (root) ->
  params = {
    pfl: $('#actividad_proyectofinanciero_ids').val(),
  }
  sip_llena_select_con_AJAX2('actividadespf', params, 
    'actividad_actividadpf_ids', 'con Actividades de convenio', root,
    'id', 'nombre')

@cor1440_gen_actividad_actualiza_pf = (root) ->
  params = {
    fecha: $('#actividad_fecha_localizada').val(),
  }
  sip_llena_select_con_AJAX2('proyectosfinancieros', params, 
    'actividad_proyectofinanciero_ids', 'con Convenios financiados', 
    root, 'id', 'nombre', 
    cor1440_gen_actividad_actualiza_actividadpf)


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
      cor1440_gen_actividad_actualiza_pf(root)
    )
    $('#actividad_fecha_localizada').datepicker({
      format: root.formato_fecha,
      autoclose: true,
      todayHighlight: true,
      language: 'es'
    }).on('changeDate', (ev) ->
      cor1440_gen_actividad_actualiza_pf(root)
    )
    $("#actividad_proyectofinanciero_ids").chosen().change( (e) ->
      cor1440_gen_actividad_actualiza_actividadpf(root)
    )


  $('#actividad_actividadpf_ids').chosen().change( (e) ->
    root = window
    ruta = document.location.pathname
    if root.puntomontaje.length > 0
      ruta = ruta.substr(window.puntomontaje.length)
    if ruta.length == 0
      return
    if ruta[0] == '/'
      ruta = ruta.substr(1)
    datos = {
      actividadpf_ids: $(this).val()
    }
    sip_envia_ajax_datos_ruta_y_pinta(ruta, datos,
      '#camposdinamicos', '#camposdinamicos')
  )

 
  $(document).on('change', '#objetivospf [id$=_numero]', cor1440_gen_actualiza_objetivos)
  
  $(document).on('cocoon:after-remove', '#objetivospf', cor1440_gen_actualiza_objetivos)
  
  $(document).on('cocoon:after-insert', '#objetivospf', cor1440_gen_actualiza_objetivos)
  
  $(document).on('cocoon:before-remove', '#objetivospf', (e, objetivo) ->
    return sip_intenta_eliminar_fila(objetivo, '/objetivospf/', DEP_OBJETIVOPF)
  )
  
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
 
