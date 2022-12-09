module Cor1440Gen
  module Concerns
    module Models
      module Tipoindicador
        extend ActiveSupport::Concern

        included do
          include Msip::Basica

          has_and_belongs_to_many :formulario, 
            class_name: 'Mr519Gen::Formulario',
            foreign_key: 'tipoindicador_id',
            association_foreign_key: 'formulario_id', 
            join_table: 'cor1440_gen_formulario_tipoindicador'

          has_many :campotind, foreign_key: 'tipoindicador_id',
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::Campotind'
          accepts_nested_attributes_for :campotind,
            allow_destroy: true, reject_if: :all_blank

          has_many :datointermedioti, dependent: :delete_all,
            class_name: 'Cor1440Gen::Datointermedioti',
            foreign_key: 'tipoindicador_id'
          accepts_nested_attributes_for :datointermedioti,
            allow_destroy: true, reject_if: :all_blank

          has_many :indicadorpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::Indicadorpf',
            foreign_key: 'tipoindicador_id'

          validates :nombre, presence: true, allow_blank: false, 
            uniqueness: true, length: { maximum: 32} 
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

