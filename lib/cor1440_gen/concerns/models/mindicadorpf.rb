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

          has_many :pmindicador, 
            foreign_key: 'mindicadorpf_id', 
            validate: true,
            dependent: :destroy, 
            class_name: 'Cor1440Gen::Pmindicadorpf'
          accepts_nested_attributes_for :pmindicador, 
            allow_destroy: true, 
            reject_if: :all_blank

          scope :filtro_proyectofinanciero_id, lambda { |pf|
            where(proyectofinanciero_id: pf)
          }

          scope :filtro_indicadorpf_id, lambda { |ipf|
            where(indicadorpf_id: ipf)
          }

        end # included

        class_methods do 
          def modelos_path
            'cor1440_gen.mindicadorespf_path'
          end
        end

      end
    end
  end
end

