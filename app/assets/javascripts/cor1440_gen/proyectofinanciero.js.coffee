
# PROYECTOS

# MONTOS EN PESOS AUTOMÁTICOS

@cor1440_gen_recalcula_aemergente_pesos_localizado = (campo, tasa) ->
  vc = $('#' + campo).val()
  if typeof vc != 'undefined' && vc != '' && typeof tasa != 'undefined' && tasa > 0
      vcp = msip_reconocer_decimal_locale_es_CO(vc)*tasa
      vcpl = new Intl.NumberFormat('es-CO').format(vcp)
      $('#' + campo).attr('title', '$ ' + vcpl).tooltip('fixTitle').tooltip('show')


@cor1440_gen_recalcula_montospesos_localizado = (root) ->

  if ($('#proyectofinanciero_tasa_localizado').length > 0)
    tfl = $('#proyectofinanciero_tasa_localizado').val()
    tf = msip_reconocer_decimal_locale_es_CO(tfl)
    sum = 0
    sump = 0
    $.each [['monto', 'montopesos'], ['aportepropio', 'aportepropiop'],
            ['aotrosfin', 'aporteotrosp'], ['saldo', 'saldop']], (i, c) ->
      vl = $('#proyectofinanciero_' + c[0] + '_localizado').val()
      v = msip_reconocer_decimal_locale_es_CO(vl)
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
    te = msip_reconocer_decimal_locale_es_CO(tel)
    sum = 0
    sump = 0
    $.each [['montoej', 'montoejp'], ['aportepropioej', 'aportepropioejp'],
            ['aporteotrosej', 'aporteotrosejp']], (i, c) ->
      vl = $('#proyectofinanciero_' + c[0] + '_localizado').val()
      v = msip_reconocer_decimal_locale_es_CO(vl)
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


