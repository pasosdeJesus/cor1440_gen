
# PROYECTOS

# DURACIÓN AUTOMÁTICA

@cor1440_gen_establece_duracion = (root, obdur) ->
  $('#proyectofinanciero_duracion').val(obdur.duracion)


@cor1440_gen_recalcula_duracion = (root) ->
  datos = {
    fechainicio_localizada: $('#proyectofinanciero_fechainicio_localizada').val(),
    fechacierre_localizada: $('#proyectofinanciero_fechacierre_localizada').val()
  }
  if datos.fechainicio_localizada != '' && datos.fechacierre_localizada != ''
    sip_ajax_recibe_json(window, 'api/cor1440gen/duracion',
      datos, cor1440_gen_establece_duracion)
  else
    $('#proyectofinanciero_duracion').val('')


@cor1440_gen_eventos_duracion = (root) ->
  $(document).on('change', '#proyectofinanciero_fechaformulacion_mes', (e) ->
    s = 2
    if $('#proyectofinanciero_fechaformulacion_mes').val() <= 6
      s = 1
    $('#proyectofinanciero_semestreformulacion').val(s)
  )

  $(document).on('change', '#proyectofinanciero_fechainicio_localizada', (e) ->
    cor1440_gen_recalcula_duracion(window)
  )

  $(document).on('change', '#proyectofinanciero_fechacierre_localizada', (e) ->
    cor1440_gen_recalcula_duracion(window)
  )

  $(document).on('change', '#proyectofinanciero_fechainicio_localizada', (e) ->
    cor1440_gen_recalcula_duracion(window)
  )

  $(document).on('change', '#proyectofinanciero_fechacierre_localizada', (e) ->
    cor1440_gen_recalcula_duracion(window)
  )


# MONTOS EN PESOS AUTOMÁTICOS

@cor1440_gen_recalcula_aemergente_pesos_localizado = (campo, tasa) ->
  vc = $('#' + campo).val()
  if typeof vc != 'undefined' && vc != '' && typeof tasa != 'undefined' && tasa > 0
      vcp = sip_reconocer_decimal_locale_es_CO(vc)*tasa
      vcpl = new Intl.NumberFormat('es-CO').format(vcp)
      $('#' + campo).attr('title', '$ ' + vcpl).tooltip('fixTitle').tooltip('show')


@cor1440_gen_recalcula_montospesos_localizado = (root) ->

  if ($('#proyectofinanciero_tasa_localizado').length > 0)
    tfl = $('#proyectofinanciero_tasa_localizado').val()
    tf = sip_reconocer_decimal_locale_es_CO(tfl)
    sum = 0
    sump = 0
    $.each [['monto', 'montopesos'], ['aportepropio', 'aportepropiop'],
            ['aotrosfin', 'aporteotrosp'], ['saldo', 'saldop']], (i, c) ->
      vl = $('#proyectofinanciero_' + c[0] + '_localizado').val()
      v = sip_reconocer_decimal_locale_es_CO(vl)
      sum += v
      vp = v * tf 
      vpl = new Intl.NumberFormat('es-CO').format(vp)
      $('#proyectofinanciero_' + c[1] + '_localizado').val(vpl)
      sump += vp
  
    suml = new Intl.NumberFormat('es-CO').format(sum)
    sumpl = new Intl.NumberFormat('es-CO').format(sump)
    $('#proyectofinanciero_presupuestototal_localizado').val(suml)
    $('#proyectofinanciero_presupuestototalp_localizado').val(sumpl)

  # Repetimos para datos en ejecucion
  if ($('#proyectofinanciero_tasaej_localizado').length > 0)
    tel = $('#proyectofinanciero_tasaej_localizado').val()
    te = sip_reconocer_decimal_locale_es_CO(tel)
    sum = 0
    sump = 0
    $.each [['montoej', 'montoejp'], ['aportepropioej', 'aportepropioejp'],
            ['aporteotrosej', 'aporteotrosejp']], (i, c) ->
      vl = $('#proyectofinanciero_' + c[0] + '_localizado').val()
      v = sip_reconocer_decimal_locale_es_CO(vl)
      sum += v
      vp = v * te
      vpl = new Intl.NumberFormat('es-CO').format(vp)
      $('#proyectofinanciero_' + c[1] + '_localizado').val(vpl)
      sump += vp
  
    suml = new Intl.NumberFormat('es-CO').format(sum)
    sumpl = new Intl.NumberFormat('es-CO').format(sump)
    $('#proyectofinanciero_presupuestototalej_localizado').val(suml)
    $('#proyectofinanciero_presupuestototalejp_localizado').val(sumpl)


  return


@cor1440_gen_eventos_montospesos = (root) ->

  $(document).on('change', '#proyectofinanciero_tasa_localizado', (e) ->
    cor1440_gen_recalcula_montospesos_localizado(root)
  )

  $(document).on('change', '#proyectofinanciero_tasaej_localizado', (e) ->
    cor1440_gen_recalcula_montospesos_localizado(root)
  )

  $.each ['monto', 'aportepropio', 'aporteotros', 
    'montoej', 'aportepropioej', 'aporteotrosej'], (i, c) ->
    $(document).on('change', '#proyectofinanciero_' + c + '_localizado', (e) ->
      cor1440_gen_recalcula_montospesos_localizado(root)
    )

  return


