source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec


gem 'bcrypt'

gem 'bootsnap', '>=1.1.0', require: false

gem 'cancancan'

gem 'cocoon', git: 'https://github.com/vtamara/cocoon.git', branch: 'new_id_with_ajax' # Formularios anidados (algunos con ajax)

gem 'coffee-rails' , '>= 5.0.0' # CoffeeScript para recuersos .js.coffee y vistas

gem 'devise', '>= 4.7.2' # Autenticación 

gem 'devise-i18n', '>= 1.9.1'

gem 'jbuilder'

gem 'libxml-ruby'

gem 'odf-report' # Genera ODT

gem 'paperclip' # Maneja adjuntos

gem 'pg' # Postgresql

gem 'puma'

gem 'prawn' # Generación de PDF

gem 'prawnto_2', '>= 0.3.0', :require => 'prawnto'

gem 'prawn-table'

gem 'rails', '~> 6.0.3.1' # Rails (internacionalización)

gem 'rails-i18n', '>= 6.0.0'

gem 'rspreadsheet'

gem 'rubyzip', '>= 2.0.0'

gem 'sassc-rails' , '>= 2.1.2' # CSS

gem 'simple_form' , '>= 5.0.2' # Formularios simples 

gem 'twitter_cldr' # ICU con CLDR

gem 'tzinfo' # Zonas horarias

gem 'webpacker', '>= 5.1.1'

gem 'will_paginate' # Pagina listados

#####
# Motores que se sobrecargan vistas (deben ponerse en orden de apilamiento 
# lógico y no alfabetico como las gemas anteriores)

gem 'sip', # Motor generico
  git: 'https://github.com/pasosdeJesus/sip.git'
  #path: '../sip'

gem 'mr519_gen', # Motor de gestion de formularios y encuestas
  git: 'https://github.com/pasosdeJesus/mr519_gen.git'
  #path: '../mr519_gen'

gem 'heb412_gen',  # Motor de nube y llenado de plantillas
  git: 'https://github.com/pasosdeJesus/heb412_gen.git'


group :development do
  
  gem 'thor' # Requerido por rake
  
  gem 'web-console' , '>= 4.0.2' # ConSola irb en páginas 
  
end


group :development, :test do

  #gem 'byebug', platform: :mri

  gem 'colorize' # Colores en Terminl

  gem 'rails-erd' # Para generar modelo entidad asociación 

end


group :test do

  gem 'connection_pool'

  gem 'minitest'

  gem 'minitest-reporters' 

  gem 'rails-controller-testing', '>= 1.0.4'

  gem 'simplecov' # Envia resultados de pruebas desde travis a codeclimate

  gem 'spring' # Acelera desarrollo ejecutando en fondo

  gem 'spork'

end

