# MEDICIÓN DE INDICADORES


@cor1440_gen_llena_medicion = (root, res) ->
  hid = res.hmindicadorpf_id
  $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_fecha_localizada]').val(res.fechaloc)
  cont = 0
  res.datosint.forEach((v) ->
    $('[id$=_' + hid + '_datointermedioti_pmindicadorpf_attributes_' + cont + '_valor]').val(v.valor)
    $('[id$=_' + hid + '_datointermedioti_pmindicadorpf_attributes_' + cont + '_rutaevidencia]').val(v.rutaevidencia)
    cont++
  )
  $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_resind]').val(res.resind)
  $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_rutaevidencia]').val(res.rutaevidencia)
  meta = +$('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_meta]').val()
  if ( meta > 0)
    $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_porcump]').val(res.resind*100/meta)
  enlace = $('[id=mindicadorpf_pmindicadorpf_attributes_' + hid + '_resind]').closest('td').find('a.enlaceevidencia')
  enlace.html(res.resind)
  enlace.attr('href', res.rutaevidencia)



@cor1440_gen_calcula_pmindicadorpf = (elem, event) ->
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
    mindicadorpf_id: $('form.edit_mindicadorpf')[0].id.split('_')[2]
  }
  sip_ajax_recibe_json(root, 'api/cor1440gen/medir_indicador', 
    datos, cor1440_gen_llena_medicion)  
  return



@cor1440_gen_preparamindicadorespf = (root) ->

  $("#cor1440_gen_mfun").hide();
  $(".cor1440_gen_funcion").bind("contextmenu", (e) ->
    window.cor1440_gen_mfun_enlace = e.target
    $("#cor1440_gen_mfun").css({'display':'block', 'left':e.pageX, 'top':e.pageY });
    return false;
  )

  $(document).click( (e) ->
    if e.button == 0
      $(".cor1440_gen_menucontextual").css("display", "none");
  )

  $(document).keydown( (e) ->
    if e.keyCode == 27
      $(".cor1440_gen_menucontextual").css("display", "none");
  )
  
  $("#cor1440_gen_mfun").click((e) ->
    root = window
    sip_arregla_puntomontaje(root)
    t = Date.now()
    d = -1
    if (root.cor1440_gen_mcarc_t)
      d = (t - root.cor1440_gen_mcarc_t)/1000
    # NO se permite mas de un envio en 2 segundos 
    if (d == -1 || d > 2)
      root.cor1440_gen_mcarc_t = t
      switch e.target.id
        when "actividades" then (
          window.cor1440_gen_mfun_enlace.value="cuenta(Actividades_contribuyentes)"
        )
        when "poblacion" then window.cor1440_gen_mfun_enlace.value='suma(mapeaproy(Actividades, poblacion))'
        when "asistentes" then window.cor1440_gen_mfun_enlace.value='cuenta(aplana(mapeaproy(Actividades_contribuyentes, Asistentes)))'
        when "asistentesunicos" then window.cor1440_gen_mfun_enlace.value='cuenta(unicos(aplana(mapeaproy(Actividades_contribuyentes, Asistentes))))'
        when "organizaciones" then window.cor1440_gen_mfun_enlace.value="cuenta(aplana(mapeaproy(Actividades_contribuyentes, Organizaciones)))"
        when "organizacionesunicas" then window.cor1440_gen_mfun_enlace.value="cuenta(unicas(aplana(mapeaproy(Actividades_contribuyentes, Organizaciones))))"
      $(".cor1440_gen_menucontextual").css("display", "none");
    return false
  )


