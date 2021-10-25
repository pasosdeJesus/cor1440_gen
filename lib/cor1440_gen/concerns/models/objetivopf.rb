module Cor1440Gen
  module Concerns
    module Models
      module Objetivopf
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper

          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id'

          has_many :indicadorpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Indicadorpf', 
            foreign_key: 'objetivopf_id'

          has_many :resultadopf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Resultadopf', 
            foreign_key: 'objetivopf_id'


          validates :numero, presence: true, length: {maximum: 15}
          validates :objetivo, presence: true, length: {maximum: 5000}

          def presenta_nombre
            numero + " " + objetivo
          end

        end # included

      end
    end
  end
end

