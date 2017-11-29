# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Resultadopf
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper

          has_many :actividadpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Actividadpf', foreign_key: 'resultadopf_id'
          has_many :indicadorpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Indicadorpf', foreign_key: 'resultadopf_id'

          belongs_to :objetivopf, 
            class_name: 'Cor1440Gen::Objetivopf',
            foreign_key: 'objetivopf_id'

          validates :numero, presence: true, length: {maximum: 15}
          validates :resultado, presence:true, length: {maximum: 5000}

          def presenta_nombre
            numero + " " + resultado
          end

        end #included

      end
    end
  end
end

