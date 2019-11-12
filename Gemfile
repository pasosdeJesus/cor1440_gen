source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec


gem 'bcrypt'

gem 'bootsnap', '>=1.1.0', require: false

gem 'cancancan'

gem 'cocoon', git: 'https://github.com/vtamara/cocoon.git', branch: 'new_id_with_ajax' # Formularios anidados (algunos con ajax)

gem 'coffee-rails' # CoffeeScript para recuersos .js.coffee y vistas

gem 'devise'# Autenticación 

gem 'devise-i18n'

gem 'jbuilder'

gem 'libxml-ruby'

gem 'odf-report' # Genera ODT

gem 'paperclip' # Maneja adjuntos

gem 'pg' # Postgresql

gem 'puma'

gem 'prawn' # Generación de PDF

gem 'prawnto_2',  :require => 'prawnto'

gem 'prawn-table'

gem 'rails', '~> 6.0.0.rc1' # Rails (internacionalización)

gem 'rails-i18n'

gem 'rspreadsheet'

gem 'rubyzip', '>= 2.0.0'

gem 'sassc-rails' # CSS

gem 'simple_form' # Formularios simples 

gem 'twitter_cldr' # ICU con CLDR

gem 'tzinfo' # Zonas horarias

gem 'webpacker'

gem 'will_paginate' # Pagina listados

#####
# Motores que se sobrecargan vistas (deben ponerse en orden de apilamiento 
# lógico y no alfabetico como las gemas anteriores)

gem 'sip', # Motor generico
  git: 'https://github.com/pasosdeJesus/sip.git', branch: :bs4
  #path: '../sip'

gem 'mr519_gen', # Motor de gestion de formularios y encuestas
  git: 'https://github.com/pasosdeJesus/mr519_gen.git', branch: :bs4
  #path: '../mr519_gen'

gem 'heb412_gen',  # Motor de nube y llenado de plantillas
  #git: 'https://github.com/pasosdeJesus/heb412_gen.git', branch: :bs4
  path: '../heb412_gen'


group :development do
  
  gem 'thor' # Requerido por rake
  
  gem 'web-console' # ConSola irb en páginas 
  
end


group :development, :test do

  #gem 'byebug', platform: :mri

  gem 'colorize' # Colores en Terminl
end


group :test do

  gem 'connection_pool'

  gem 'minitest'

  gem 'minitest-reporters' 

  gem 'rails-controller-testing'

  gem 'simplecov' # Envia resultados de pruebas desde travis a codeclimate

  gem 'spring' # Acelera desarrollo ejecutando en fondo

  gem 'spork'

end

