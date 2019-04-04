# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module PlantillahcmProyectofinanciero
        extend ActiveSupport::Concern

        included do

          belongs_to :plantillahcm, class_name: 'Heb512Gen::Plantillahcm', 
            foreign_key: 'plantillahcm_id'
          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id'

        end # included
      end
    end
  end
end



