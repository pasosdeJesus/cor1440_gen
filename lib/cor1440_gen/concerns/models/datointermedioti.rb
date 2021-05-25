
module Cor1440Gen
  module Concerns
    module Models
      module Datointermedioti
        extend ActiveSupport::Concern

        included do

          belongs_to :tipoindicador, class_name: 'Cor1440Gen::Tipoindicador',
            foreign_key: 'tipoindicador_id'

          validates :nombre, length: { maximum: 1024}
          validates :nombre_interno, length: { maximum: 127}
          validates :nombre_interno, format: {with: /[a-z_]+/}
          validates :filtro, length: { maximum: 5000}
          validates :funcion, length: { maximum: 5000}

          def presenta_nombre
            nombre
          end

        end # included

      end
    end
  end
end

