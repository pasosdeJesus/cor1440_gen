# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Tipoindicador
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 
          include Sip::Localizacion

          has_many :indicadorpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Indicadorpf',
            foreign_key: 'tipoindicador_id'

          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 32} 
          validates :medircon, presence: true, allow_blank: false
          validates :espcampos, length: { maximum: 1000 } 
          validates :espvaloresomision, length: { maximum: 1000 } 
          validates :espvalidaciones, length: { maximum: 1000 } 
          validates :esptipometa, length: { maximum: 32 } 
          validates :espfuncionmedir, length: { maximum: 1000 } 

          def presenta(atr)
            if atr == 'medircon'
              case medircon
              when 1 
                return 'Actividades'
              when 2
                return 'Efectos'
              end
            end
            return presenta_gen(atr)
          end

        end
      end
    end
  end
end

