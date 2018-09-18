# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Indicadorpf
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper

          belongs_to :objetivopf, 
            class_name: 'Cor1440Gen::Objetivopf',
            foreign_key: 'objetivopf_id'
          belongs_to :resultadopf, 
            class_name: 'Cor1440Gen::Resultadopf',
            foreign_key: 'resultadopf_id'
          belongs_to :tipoindicador, 
            class_name: 'Cor1440Gen::Tipoindicador',
            foreign_key: 'tipoindicador_id'


          validates :numero, presence: true, length: {maximum: 15}
          validates :indicador, presence:true, length: {maximum: 5000}

          def presenta_nombre
            numero + " " + indicador 
          end

        end # included

      end
    end
  end
end

