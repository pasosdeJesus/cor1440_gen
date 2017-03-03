source 'https://rubygems.org'

# Rails (internacionalización)
gem "rails", '~> 5.0.0'
gem "rails-i18n"

# Postgresql
gem "pg"

gem 'puma'

# CSS
gem "sass"

# Colores en Terminl
gem "colorize"

# Generación de PDF
gem "prawn"
gem "prawnto_2",  :require => "prawnto"
gem "prawn-table"

# Plantilla ODT
gem "odf-report"

# API JSON facil. Ver: https://github.com/rails/jbuilder
gem "jbuilder"

# Uglifier comprime recursos Javascript
gem "uglifier"#, '>= 1.3.0'

# CoffeeScript para recuersos .js.coffee y vistas
gem "coffee-rails"#, '~> 4.1.0'

# jquery como librería JavaScript
gem "jquery-rails"
gem "jquery-ui-rails"
#gem "jquery-ui-bootstrap-rails", git: "https://github.com/kristianmandrup/jquery-ui-bootstrap-rails"

# Seguir enlaces más rápido. Ver: https://github.com/rails/turbolinks
gem "turbolinks"#, "2.5.3"

# Ambiente de CSS
gem "twitter-bootstrap-rails"
gem "font-awesome-rails"
gem "bootstrap-datepicker-rails"

# Formularios simples 
gem "simple_form"

# Formularios anidados (algunos con ajax)
gem "cocoon", git: "https://github.com/vtamara/cocoon.git"

# Autenticación y roles
gem "devise"
gem "devise-i18n"
gem "cancancan"
gem "bcrypt"

# Pagina listados
gem "will_paginate"

# ICU con CLDR
gem 'twitter_cldr'
 
# Maneja adjuntos
gem "paperclip"#, "~> 4.1"

# Zonas horarias
gem "tzinfo"
gem "tzinfo-data"

# Motor Sip
#gem 'sip', git: "https://github.com/pasosdeJesus/sip.git"
gem 'sip', path: '../sip'

# Los siguientes son para desarrollo o para pruebas con generadores
group :development do
  # Requerido por rake
  gem "thor"

  # Depurar
  gem 'byebug'
  
  # ConSola irb en páginas con excepciones o usando <%= console %> en vistasA
  gem 'web-console'
end

# Los siguientes son para pruebas y no tiene generadores requeridos en desarrollo
group :test do
  # Envia resultados de pruebas desde travis a codeclimate
  #gem "codeclimate-test-reporter", require: nil

  gem 'rails-controller-testing'

  # Acelera desarrollo ejecutando en fondo. https://github.com/jonleighton/spring
  gem "spring"
  gem "connection_pool"
  gem "minitest-reporters" 
  gem "poltergeist" 
  gem 'minitest-rails-capybara'

  
  # Un proceso para cada prueba -- acelera
  gem 'spork'#, '~> 1.0rc'

  # Maneja datos de prueba
  gem "factory_girl_rails", group: [:development, :test] #, "~> 4.0"

  # https://www.relishapp.com/womply/rails-style-guide/docs/developing-rails-applications/bundler
  # Lanza programas para examinar resultados
  gem "launchy"

  # Para examinar errores, usar "rescue rspec" en lugar de "rspec"
  gem 'pry-rescue'
  gem 'pry-stack_explorer'
end

