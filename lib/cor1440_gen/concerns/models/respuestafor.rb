# encoding: UTF-8

require 'mr519_gen/concerns/models/respuestafor'

module Cor1440Gen
  module Concerns
    module Models
      module Respuestafor
        extend ActiveSupport::Concern

        included do
          include Mr519Gen::Concerns::Models::Respuestafor

          has_and_belongs_to_many :actividad, 
            class_name: 'Cor1440Gen::Actividad', 
            foreign_key: 'respuestafor_id',
            association_foreign_key: 'actividad_id',
            join_table: 'cor1440_gen_actividad_respuestafor'

          has_and_belongs_to_many :efecto, 
            class_name: 'Cor1440Gen::Efecto', 
            foreign_key: 'respuestafor_id',
            association_foreign_key: 'efect_id',
            join_table: 'cor1440_gen_efecto_respuestafor'

        end # included
      end
    end
  end
end



