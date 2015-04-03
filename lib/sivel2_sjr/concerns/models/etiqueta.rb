# encoding: UTF-8

require 'sivel2_gen/concerns/models/etiqueta'

module Sivel2Sjr
  module Concerns
    module Models
      module Etiqueta
        extend ActiveSupport::Concern
        include Sivel2Gen::Concerns::Models::Etiqueta

        included do
          has_many :etiqueta_usuario, class_name: 'Sivel2Gen::EtiquetaUsuario',
            dependent: :delete_all
          has_many :usuario, class_name: 'Usuario', through: :etiqueta_usuario
        end

        module ClassMethods
        end

      end
    end
  end
end
