# cor1440_gen : Motor para planeación y seguimiento de actividades e informes en una ONG
[![Estado Construcción](https://api.travis-ci.org/pasosdeJesus/cor1440_gen.svg?branch=master)](https://travis-ci.org/pasosdeJesus/cor1440_gen) [![Clima del Código](https://codeclimate.com/github/pasosdeJesus/cor1440_gen/badges/gpa.svg)](https://codeclimate.com/github/pasosdeJesus/cor1440_gen) [![Cobertura de Pruebas](https://codeclimate.com/github/pasosdeJesus/cor1440_gen/badges/coverage.svg)](https://codeclimate.com/github/pasosdeJesus/cor1440_gen) [![security](https://hakiri.io/github/pasosdeJesus/cor1440_gen/master.svg)](https://hakiri.io/github/pasosdeJesus/cor1440_gen/master) [![Dependencias](https://gemnasium.com/pasosdeJesus/cor1440_gen.svg)](https://gemnasium.com/pasosdeJesus/cor1440_gen) 


Este es un motor para sistemas de información de planeación y seguimiento de actividades en una ONG. Opera sobre Ruby on Rails 4.2 y PostgreSQL (preferiblemente cifrado como en adJ).

Este motor incluye 
* Uso del motor sip (que a su vez maneja devise, cancancan, rspec, tablas básicas con datos geográficos para varios paises, manejo de anexos con paperclip, facilidades de configuracion como puede ver en https://github.com/pasosdeJesus/sip)
* 
* Aplicación de prueba completa en spec/dummy con diseño adaptable a
  dispositivos moviles o de escritorio (responsive) usando bootstrap, 
  simple_form y jquery que permite modificar las tablas 
  básicas paginando con will_paginate, y manejar actividades mínimas.  
  Para agregar anexos y participantes por rangos de edad usa AJAX manejado
  por versión modificada de cocoon.

## Diseño, Uso, Pruebas y Desarrollo

Sigue los mismos lineamientos del motor sip, cuyas instrucciones
generales puede consultar en https://github.com/pasosdeJesus/sip

Los cambios a esas instrucciones son:

* El usuario por defecto en PostgreSQL configurado es cor1440gen con
  clave xyz, pero puede modificarlo despues de copia la plantilla
  spec/dummy/config/database.yml.plantilla en spec/dummy/config/daabase.yml
* El usuario inicial tras crear una nueva aplicación es cor1440 con
  clave cor1440

