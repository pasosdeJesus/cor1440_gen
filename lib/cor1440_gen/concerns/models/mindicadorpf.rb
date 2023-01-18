# frozen_string_literal: true
module Cor1440Gen
  module Concerns
    module Models
      module Mindicadorpf
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion

          MEDIRCON_OPCIONES = [
            ['Actividades', 1],
            ['Avances en efecto', 2],
            ['Otro', 3],
          ]

          belongs_to :proyectofinanciero,
            class_name: 'Cor1440Gen::Proyectofinanciero',
            optional: false
          belongs_to :indicadorpf,
            class_name: 'Cor1440Gen::Indicadorpf',
            optional: false

          has_many :pmindicadorpf,
            foreign_key: 'mindicadorpf_id',
            validate: true,
            dependent: :delete_all,
            class_name: 'Cor1440Gen::Pmindicadorpf'
          accepts_nested_attributes_for :pmindicadorpf,
            allow_destroy: true,
            reject_if: :all_blank

          has_and_belongs_to_many :actividadpf,
            class_name: 'Cor1440Gen::Actividadpf',
            foreign_key: 'mindicadorpf_id',
            association_foreign_key: 'actividadpf_id',
            join_table: 'cor1440_gen_actividadpf_mindicadorpf'

          has_and_belongs_to_many :formulario,
            class_name: 'Mr519Gen::Formulario',
            foreign_key: 'mindicadorpf_id',
            association_foreign_key: 'formulario_id',
            join_table: 'cor1440_gen_formulario_mindicadorpf'

          has_many :datointermedioti,
            dependent: :delete_all,
            class_name: 'Cor1440Gen::Datointermedioti',
            foreign_key: 'mindicadorpf_id',
            validate: true
          accepts_nested_attributes_for :datointermedioti,
            allow_destroy: true,
            reject_if: :all_blank

          validates :medircon, inclusion: [1, 2, 3]

          validate :sintaxis_funcionresultado
          def sintaxis_funcionresultado
            menserr = ''
            if funcionresultado.to_s != '' &&
                !Cor1440Gen::MedicionHelper.revisa_sintaxis_expresion(
                  funcionresultado, menserr
)
              errors.add(:funcionresultado, menserr)
              return false
            end
            true
          end

          scope :filtro_proyectofinanciero_id, lambda { |pf|
            where(proyectofinanciero_id: pf)
          }

          scope :filtro_indicadorpf_id, lambda { |ipf|
            where(indicadorpf_id: ipf)
          }

          def presenta(atr)
            case atr.to_s
            when 'actividadpf'
              m = actividadpf_ids.map do |idapf|
                apf = Cor1440Gen::Actividadpf.find(idapf)
                apf.presenta_nombre
              end
              return m.join('; ')
            when 'medircon'
              r = MEDIRCON_OPCIONES.select {|m| m[1] == medircon}
              return r.length == 1 ? r[0][0] : 'Otro'
            when 'tipoindicador'
              if indicadorpf && indicadorpf.tipoindicador
                return indicadorpf.tipoindicador.nombre
              else
                return ''
              end
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
