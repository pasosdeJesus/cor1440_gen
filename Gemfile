source 'https://rubygems.org'

# Rails (internacionalización)
gem 'rails', '~> 6.0.0.rc1'

gem 'bootsnap', '>=1.1.0', require: false

gem 'rails-i18n'

# Postgresql
gem 'pg'#, '~> 0.21'

gem 'puma'

# CSS
gem 'sass'

gem 'webpacker'

# Colores en Terminl
gem 'colorize'

# Generación de PDF
gem 'prawn'
gem 'prawnto_2',  :require => 'prawnto'
gem 'prawn-table'

# Plantilla ODT
gem 'odf-report'



gem 'chosen-rails', git: 'https://github.com/vtamara/chosen-rails.git', branch: 'several-fixes'

gem 'rspreadsheet'
#gem 'rspreadsheet', path: '../rspreadsheet/'
gem 'libxml-ruby', '~> 3.0'

# API JSON facil. Ver: https://github.com/rails/jbuilder
gem 'jbuilder'

# Uglifier comprime recursos Javascript
gem 'uglifier'#, '>= 1.3.0'

# CoffeeScript para recuersos .js.coffee y vistas
gem 'coffee-rails'#, '~> 4.1.0'

# jquery como librería JavaScript
gem 'jquery-rails'
gem 'jquery-ui-rails'
#gem 'jquery-ui-bootstrap-rails', git: 'https://github.com/kristianmandrup/jquery-ui-bootstrap-rails'

# Seguir enlaces más rápido. Ver: https://github.com/rails/turbolinks
gem 'turbolinks'#, '2.5.3'

# Ambiente de CSS
gem 'twitter-bootstrap-rails'
gem 'font-awesome-rails'
gem 'bootstrap-datepicker-rails'

# Facilita elegir colores en tema
gem 'pick-a-color-rails'
gem 'tiny-color-rails'

# Formularios simples 
gem 'simple_form'

# Formularios anidados (algunos con ajax)
gem 'cocoon', git: 'https://github.com/vtamara/cocoon.git', branch: 'new_id_with_ajax'


# Autenticación y roles
gem 'devise', '>= 4.7.1'
gem 'devise-i18n', '>= 1.8.1'
gem 'cancancan'
gem 'bcrypt'

# Pagina listados
gem 'will_paginate'

# ICU con CLDR
gem 'twitter_cldr'
 
# Maneja adjuntos
gem 'paperclip'#, '~> 4.1'

# Zonas horarias
gem 'tzinfo'
#gem 'tzinfo-data', platforms:  [:mingw, :mswin, :x64_mingw, :jruby]

# Motor Sip
gem 'sip', git: 'https://github.com/pasosdeJesus/sip.git'
#gem 'sip', path: '../sip'

# Motor para formularios
gem 'mr519_gen', git: 'https://github.com/pasosdeJesus/mr519_gen.git'
#gem 'mr519_gen', path: '../mr519_gen/'

# Motor heb412_gen para manejar archivos como nube y plantillas
gem 'heb412_gen', git: 'https://github.com/pasosdeJesus/heb412_gen.git'
#gem 'heb412_gen', path: '../heb412_gen/'

# Los siguientes son para desarrollo o para pruebas con generadores
group :development do
  # Requerido por rake
  gem 'thor'
  # ConSola irb en páginas con excepciones o usando <%= console %> en vistasA
  gem 'web-console'
  
end

group :development, :test do
  #gem 'byebug', platform: :mri
end

# Los siguientes son para pruebas y no tiene generadores requeridos en desarrollo
group :test do
  gem 'simplecov'
  # Envia resultados de pruebas desde travis a codeclimate

  gem 'rails-controller-testing'

  # Acelera desarrollo ejecutando en fondo. https://github.com/jonleighton/spring
  gem 'spring'
  gem 'connection_pool'
  gem 'minitest'
  gem 'minitest-reporters' 

  
  # Un proceso para cada prueba -- acelera
  #gem 'minitest-rails-capybara'
  gem 'spork'#, '~> 1.0rc'

  # https://www.relishapp.com/womply/rails-style-guide/docs/developing-rails-applications/bundler
  # Lanza programas para examinar resultados
  gem 'launchy'

  # Para examinar errores, usar 'rescue rspec' en lugar de 'rspec'
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

