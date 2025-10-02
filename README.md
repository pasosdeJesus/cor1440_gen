# cor1440_gen : Motor para planeación y seguimiento de actividades e informes en una ONG

[![Revisado por Hound](https://img.shields.io/badge/Reviewed_by-Hound-8E64B0.svg)](https://houndci.com) Pruebas y seguridad:[![Estado Construcción](https://gitlab.com/pasosdeJesus/cor1440_gen/badges/main/pipeline.svg)](https://gitlab.com/pasosdeJesus/cor1440_gen/-/pipelines?page=1&scope=all&ref=main) [![Integración continua github](https://github.com/pasosdeJesus/cor1440_gen/actions/workflows/rubyonrails.yml/badge.svg?branch=v2.2)](https://github.com/pasosdeJesus/cor1440_gen/actions/workflows/rubyonrails.yml) [![CodeQL en github](https://github.com/pasosdeJesus/cor1440_gen/actions/workflows/codeql-analysis.yml/badge.svg)](https://github.com/pasosdeJesus/cor1440_gen/actions/workflows/codeql-analysis.yml)


![Logo de cor1440](https://gitlab.com/pasosdeJesus/cor1440_gen/-/raw/main/test/dummy/app/assets/images/logo.jpg)

Este es un motor para sistemas de información de planeación y seguimiento de 
actividades en ONGs. Opera sobre Ruby on Rails y PostgreSQL (preferiblemente 
cifrado como en adJ).

La aplicación ```cor1440``` disponible en 
<https://gitlab.com/pasosdeJesus/cor1440>
utiliza este motor sin personalización alguna.  Puede ver ejemplos de 
personalizaciones en <https://gitlab.com/pasosdeJesus/si_fasol> y 
<https://github.com/pasosdeJesus/si_jrscol>


## Diseño, Uso, Pruebas y Desarrollo

Este motor incluye 
* Uso del motor msip (que a su vez maneja devise, cancancan, rspec, tablas 
  básicas con datos geográficos para varios paises, manejo de anexos con 
  paperclip, facilidades de configuracion como puede ver en 
  https://gitlab.com/pasosdeJesus/msip )
* Aplicación de prueba completa en spec/dummy con diseño adaptable a
  dispositivos moviles o de escritorio (responsive) que permite modificar
  las tablas básicas y manejar actividades mínimas con anexos.

Sigue los mismos lineamientos del motor msip, cuyas instrucciones
generales puede consultar en https://gitlab.com/pasosdeJesus/msip

Los cambios a esas instrucciones son:

- El usuario por defecto en PostgreSQL configurado es cor1440gen con
  clave xyz, pero puede modificarlo despues de copiar la plantilla
  spec/dummy/config/database.yml.plantilla en spec/dummy/config/database.yml
- El usuario inicial tras crear una nueva aplicación es ```cor1440``` con
  clave ```cor1440```

Algunos detalles de la implementación:

- El diseño adaptable se hizo con bootstrap, simple_form y jquery, la
  paginación al presentar listados con will_paginate.
- El manejo dinámico de anexos y participantes en una actividad 
  se hace es con AJAX manejado por versión modificada de cocoon.  
- El filtro de actividades se inspira en datatable.net --aunque no se usa
  esa librería en el momento.
- La generación de PDF del resultado de un filtrado se hace con prawnto_2


## Personalizaciones

- El controlador de actividades se ha dejado en ```lib/cor1440_gen/concerns/controllers``` para incluirlo en el controlador de ```app/controllers/cor1440_gen/actividades_controller.rb```  y facilitar su personalización.
- Los datos comunes del listado de actividades en HTML (vista ```app/view/cor1440_gen/actividades/index.html.erb``` que usa ```app/view/cor1440_gen/actividades/_indextabla.html.erb```), el PDF del listado generado con prawn (vista ```app/view/cor1440_gen/actividades/index.pdf.prawn```) y el detalle de una actividad (vista ```app/view/cor1440_gen/actividades/show```) emplean los arreglos ```@enctabla``` (con primeros titulos de encabezados) y ```@cuerpotabla``` (con matriz por mostrar, con columnas que corresponden a @enctabla).  Estas variables son establecidas en el controlador con las funciones ```encabezado_comun```, ```fila_comun``` del controlador.  Así en personalizaciones que cambién el modelo ```Cor1440Gen::Actividad``` puede ser más sencillo incluir el controlador genérico y sobrecargar sólo las funciones ```encabezado_comun``` y ```fila_comun```. Para cambios mayores puede modificarse el controlador completo y sus vistas.
- Para cambiar el filtro de manera simple en el momento basta sobrecargar la vista ```cor1440_gen/actividades/index_filtro.html.erp``` y la función ```filtra``` del controlador.
