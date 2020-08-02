
module Cor1440Gen
  module Concerns
    module Models
      module Datointermedioti
        extend ActiveSupport::Concern

        included do

          belongs_to :tipoindicador, class_name: 'Cor1440Gen::Tipoindicador',
            foreign_key: 'tipoindicador_id'

          validates :nombre, length: { maximum: 1024}

          def presenta_nombre
            nombre
          end

        end # included

      end
    end
  end
end

