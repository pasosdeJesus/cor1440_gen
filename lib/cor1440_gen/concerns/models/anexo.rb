# encoding: UTF-8

require 'sip/concerns/models/anexo'

module Cor1440Gen
  module Concerns
    module Models
      module Anexo
        extend ActiveSupport::Concern
        include Sip::Concerns::Models::Anexo

        included do
          has_many :actividad_sip_anexo, foreign_key: "anexo_id", 
            validate: true, class_name: 'Cor1440Gen::ActividadSipAnexo'
          has_many :actividad, class_name: 'Cor1440Gen::Actividad',
            through: :actividad_sip_anexo
        end

        module ClassMethods
        end

      end
    end
  end
end
