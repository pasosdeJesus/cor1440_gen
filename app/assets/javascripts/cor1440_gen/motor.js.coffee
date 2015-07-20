# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require sip/motor
#//= require jquery-ui/autocomplete
#//= require cocoon

cor1440_gen_rangoedadac = ($this) ->
  cid = $this.attr('id')
  col = cid.substr(-2)
  ini = cid.substr(0, cid.length - 5)
  sumc = 0
  i = 0
  loop
    bid = "#" + ini + "_" + i + "_" + col
    break if $(bid).size() ==  0
    sumc += parseInt($(bid).val())
    i++
  $("#tactividad" + col).text(sumc)
  fl = parseInt($("#tactividadfl").text())
  fr = parseInt($("#tactividadfr").text())
  ml = parseInt($("#tactividadml").text())
  mr = parseInt($("#tactividadmr").text())
  $("#tactividadtot").text(fl + fr + ml + mr)
  return

@cor1440_gen_prepara_eventos_comunes = (root) ->
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

