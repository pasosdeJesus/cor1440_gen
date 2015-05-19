# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require sip/geo

# Envia con AJAX datos del formulario, junto con el botón submit.
# @param root Raiz del documento, para guardar allí variable global.
enviaFormulario = (root) ->
  f = $('form')
  a = f.attr('action')
  d = f.serialize()
  d += '&commit=Enviar'
  # Parece que en ocasiones lanza 2 veces seguidas el mismo evento
  # y PostgreSQL produce error por 2 creaciones practicamente
  # simultaneas de la vista. Evitamos enviar lo mismo.
  if (!root.dant || root.dant != d)
    $.ajax(url: a, data: d, dataType: "script").fail( (jqXHR, texto) ->
      alert("Error con ajax " + texto)
    )
  root.dant = d 
  return


$(document).on 'ready page:load',  -> 
  root = exports ? this
  $(document).on('changeDate', '[data-enviarautomatico]', 
    (e) -> enviaFormulario(root)
  )
  $(document).on('change', 'select[data-enviarautomatico]', 
    (e) -> enviaFormulario(root)
  )
  $(document).on('change', 'input[data-enviarautomatico]:not([data-behaviour])', 
    (e) -> enviaFormulario(root)
  )
  $('[data-behaviour~=datepicker]').datepicker({
    format: 'yyyy-mm-dd'
    autoclose: true
    todayHighlight: true
    language: 'es'	
  });


