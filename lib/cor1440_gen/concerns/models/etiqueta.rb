# encoding: UTF-8

require 'sip/concerns/models/etiqueta'

module Cor1440Gen
  module Concerns
    module Models
      module Etiqueta
        extend ActiveSupport::Concern
        include Sip::Concerns::Models::Etiqueta

        included do
#          has_many :etiqueta_usuario, class_name: 'Sip::EtiquetaUsuario',
#            dependent: :delete_all
#          has_many :usuario, class_name: 'Usuario', through: :etiqueta_usuario
        end

        module ClassMethods
        end

      end
    end
  end
end
