module Cor1440Gen
  module Concerns
    module Models
      module Resultadopf
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper

          belongs_to :objetivopf, 
            class_name: 'Cor1440Gen::Objetivopf',
            foreign_key: 'objetivopf_id', optional: false

          has_many :actividadpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Actividadpf', 
            foreign_key: 'resultadopf_id'
          has_many :indicadorpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Indicadorpf', foreign_key: 'resultadopf_id'


          validates :numero, presence: true, length: {maximum: 15},
            format: { with: /\A[_. 0-9a-zA-Z]+\z/, 
                      message: "Solo digitos, letras, punto y raya al piso" }
          validates :resultado, presence:true, length: {maximum: 5000}

          def presenta_nombre
            objetivopf.numero + numero + " " + resultado
          end

          def codigo_completo
            objetivopf.numero + numero
          end

        end #included

      end
    end
  end
end

