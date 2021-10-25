require 'heb412_gen/concerns/models/plantillahcm'

module Cor1440Gen
  module Concerns
    module Models
      module Plantillahcm
        extend ActiveSupport::Concern

        included do
          include Heb412Gen::Concerns::Models::Plantillahcm

          has_and_belongs_to_many :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'plantillahcm_id',
            association_foreign_key: 'proyectofinanciero_id',
            join_table: 'cor1440_gen_plantillahcm_proyectofinanciero'

        end # included
      end
    end
  end
end



