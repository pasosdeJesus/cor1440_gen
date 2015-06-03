#//= require sip/bootstrap.js

$(document).on 'ready page:load',  -> 
  $('[data-behaviour~=datepicker]').datepicker({
    format: 'yyyy-mm-dd'
    autoclose: true
    todayHighlight: true
    language: 'es'	
  });

