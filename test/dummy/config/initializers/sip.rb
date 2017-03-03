# encoding: UTF-8

require 'cor1440_gen/version'

Sip.setup do |config|
      config.ruta_anexos = "#{Rails.root}/archivos/anexos"
      config.ruta_volcados = "#{Rails.root}/archivos/bd"
      # En heroku los anexos son super-temporales
      if !ENV["HEROKU_POSTGRESQL_GREEN_URL"].nil?
        config.ruta_anexos = "#{Rails.root}/tmp/"
      end
      config.titulo = "Cor1440 - Gen " + Cor1440Gen::VERSION
end
