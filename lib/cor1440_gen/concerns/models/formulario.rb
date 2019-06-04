# encoding: UTF-8

require 'mr519_gen/concerns/models/formulario'

module Cor1440Gen
  module Concerns
    module Models
      module Formulario
        extend ActiveSupport::Concern

        included do
          include Mr519Gen::Concerns::Models::Formulario

          has_and_belongs_to_many :actividadtipo, 
            class_name: 'Cor1440Gen::Actividadtipo', 
            foreign_key: 'formulario_id',
            association_foreign_key: 'actividadtipo_id',
            join_table: 'cor1440_gen_actividadtipo_formulario'

          has_and_belongs_to_many :caracterizacion, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'formulario_id',
            association_foreign_key: 'proyectofinanciero_id',
            join_table: 'cor1440_gen_caracterizacionpf'


        end # included
      end
    end
  end
end



