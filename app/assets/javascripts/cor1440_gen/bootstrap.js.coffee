#//= require sip/bootstrap.js

$(document).on 'ready page:load',  -> 
  $('[data-behaviour~=datepicker]').datepicker({
    format: 'dd-mm-yyyy'
    autoclose: true
    todayHighlight: true
    language: 'es'	
  });

