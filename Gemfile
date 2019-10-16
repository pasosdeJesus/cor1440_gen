source 'https://rubygems.org'

git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gemspec


gem 'bcrypt'

gem 'bootsnap', '>=1.1.0', require: false

gem 'bootstrap-datepicker-rails'

gem 'cancancan'

gem 'cocoon', git: 'https://github.com/vtamara/cocoon.git', branch: 'new_id_with_ajax' # Formularios anidados (algunos con ajax)

gem 'coffee-rails' # CoffeeScript para recuersos .js.coffee y vistas

gem 'colorize' # Colores en Terminl

gem 'chosen-rails', git: 'https://github.com/vtamara/chosen-rails.git', branch: 'several-fixes'

gem 'devise'# Autenticación 

gem 'devise-i18n'

gem 'font-awesome-rails'

# Motor heb412_gen para manejar archivos como nube y plantillas
gem 'heb412_gen', git: 'https://github.com/pasosdeJesus/heb412_gen.git'
#gem 'heb412_gen', path: '../heb412_gen/'

gem 'jbuilder'

gem 'jquery-rails' # jquery como librería JavaScript

gem 'jquery-ui-rails'

gem 'libxml-ruby'

# Motor para formularios
gem 'mr519_gen', git: 'https://github.com/pasosdeJesus/mr519_gen.git'
#gem 'mr519_gen', path: '../mr519_gen/'

gem 'odf-report' # Genera ODT

gem 'paperclip' # Maneja adjuntos

gem 'pg' # Postgresql

gem 'pick-a-color-rails' # Facilita elegir colores en tema

gem 'puma'

gem 'prawn' # Generación de PDF

gem 'prawnto_2',  :require => 'prawnto'

gem 'prawn-table'

gem 'rails', '~> 6.0.0.rc1' # Rails (internacionalización)

gem 'rails-i18n'

gem 'rspreadsheet'

gem 'rubyzip', '>= 2.0.0'

gem 'sass' # CSS

gem 'simple_form' # Formularios simples 

# Motor Sip
gem 'sip', git: 'https://github.com/pasosdeJesus/sip.git'
#gem 'sip', path: '../sip'

gem 'tiny-color-rails'

gem 'twitter-bootstrap-rails' # Ambiente de CSS

gem 'twitter_cldr' # ICU con CLDR

gem 'turbolinks' # Seguir enlaces más rápido

gem 'tzinfo' # Zonas horarias

gem 'uglifier' # Uglifier comprime recursos Javascript

gem 'webpacker'

gem 'will_paginate' # Pagina listados



group :development do
  
  gem 'thor' # Requerido por rake
  
  gem 'web-console' # ConSola irb en páginas 
  
end


group :development, :test do

  #gem 'byebug', platform: :mri
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

