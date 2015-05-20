# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

#//= require sip/enviarautomatico

$(document).on 'ready page:load',  -> 
  $(document).on('click', '.envia_generar_pdf', (e) -> 
    f = $(this).closest("form")
    f.attr("action", e.target.form.action + ".pdf")
    #f.submit()
  )
 
