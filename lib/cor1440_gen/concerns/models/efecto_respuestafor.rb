module Cor1440Gen
  module Concerns
    module Models
      module EfectoRespuestafor
        extend ActiveSupport::Concern

        included do

          belongs_to :respuestafor, class_name: 'Mr519Gen::Respuestafor',
            foreign_key: 'respuestafor_id'
          belongs_to :efecto, class_name: 'Cor1440Gen::Efecto',
            foreign_key: 'efecto_id'

        end
      end
    end
  end
end

