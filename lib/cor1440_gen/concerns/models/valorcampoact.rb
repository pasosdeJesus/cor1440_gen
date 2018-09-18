# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Valorcampoact
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 

          belongs_to :actividad, class_name: '::Cor1440Gen::Actividad',
            foreign_key: 'actividad_id'
          belongs_to :campoact, class_name: '::Cor1440Gen::Campoact',
            foreign_key: 'campoact_id'

          validates :valor, length: { maximum: 5000}

          def presenta_nombre
            r = "#{campoact.presenta_nombre}: "
            if !campoact.tipo || campoact.tipo == 1 || campoact.tipo == 2 || 
              campoact.tipo == 3
              r += "#{valor.to_s}"
            elsif campoact.tipo == 4
              r += valor.to_i == 0 ? "NO" : "SI"
            end
            r
          end

        end # included
      end
    end
  end
end

