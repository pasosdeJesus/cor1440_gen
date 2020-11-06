# encoding: UTF-8

require 'mr519_gen/concerns/models/usuario'


module Cor1440Gen
  module Concerns
    module Models
      module Usuario
        extend ActiveSupport::Concern

        included do
          include Mr519Gen::Concerns::Models::Usuario

          belongs_to :oficina, class_name: 'Sip::Oficina',
            foreign_key: "oficina_id", validate: true, optional: true

          has_and_belongs_to_many :actividad, 
            foreign_key: 'usuario_id',
            class_name: 'Cor1440Gen::Actividad',
            association_foreign_key: 'actividad_id',
            join_table: 'cor1440_gen_actividad_usuario'

          has_many :filtroresponsable, 
            class_name: 'Cor1440Gen::Informe',
            foreign_key: 'filtroresponsable',
            dependent: :delete_all
          has_many :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'responsable_id',
            dependent: :delete_all

          has_many :proyectofinanciero_usuario, #dependent: :destroy,
            class_name: 'Cor1440Gen::ProyectofinancieroUsuario',
            foreign_key: 'usuario_id'
          has_many :proyectofinanciero, through: :proyectofinanciero_usuario,
            class_name: 'Cor1440Gen::Proyectofinanciero'

          scope :filtro_oficina_id, lambda {|o|
            where(oficina_id: o)
          }

        end

      end
    end
  end
end

