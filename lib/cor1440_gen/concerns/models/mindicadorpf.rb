# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Mindicadorpf
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 
          include Sip::Localizacion

          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'proyectofinanciero_id'
          belongs_to :indicadorpf, 
            class_name: 'Cor1440Gen::Indicadorpf', 
            foreign_key: 'indicadorpf_id'

          has_many :pmindicadorpf, 
            foreign_key: 'mindicadorpf_id', 
            validate: true,
            dependent: :destroy, 
            class_name: 'Cor1440Gen::Pmindicadorpf'
          accepts_nested_attributes_for :pmindicadorpf, 
            allow_destroy: true, 
            reject_if: :all_blank

          has_and_belongs_to_many :actividadpf, 
            class_name: 'Cor1440Gen::Actividadpf',
            foreign_key: 'mindicadorpf_id',
            association_foreign_key: 'actividadpf_id',
            join_table: 'cor1440_gen_actividadpf_mindicadorpf'

          scope :filtro_proyectofinanciero_id, lambda { |pf|
            where(proyectofinanciero_id: pf)
          }

          scope :filtro_indicadorpf_id, lambda { |ipf|
            where(indicadorpf_id: ipf)
          }


          def presenta(atr)
            case atr.to_s
            when 'actividadpf'
              m = actividadpf_ids.map {|idapf| 
                apf = Cor1440Gen::Actividadpf.find(idapf)
                apf.resultadopf.numero + apf.nombrecorto
              }
              return m.join(', ')
            when 'tipoindicador'
              return (indicadorpf && indicadorpf.tipoindicador ?
                      indicadorpf.tipoindicador.nombre : '')
            end
            presenta_gen(atr)
          end


        end # included

#        class_methods do 
#          def modelos_path
#            'mindicadorespf_path'
#          end
#        end

      end
    end
  end
end

