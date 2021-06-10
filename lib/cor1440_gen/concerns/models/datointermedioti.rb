
module Cor1440Gen
  module Concerns
    module Models
      module Datointermedioti
        extend ActiveSupport::Concern

        included do

          belongs_to :mindicadorpf, class_name: 'Cor1440Gen::Mindicadorpf',
            foreign_key: 'mindicadorpf_id'

          belongs_to :tipoindicador, class_name: 'Cor1440Gen::Tipoindicador',
            foreign_key: 'tipoindicador_id'

          validates :nombre, length: { maximum: 1024}
          validates :nombreinterno, length: { maximum: 127}
          validates :nombreinterno, format: {with: /\A[a-z_][a-z_]*\z/}
          validates :funcion, length: { maximum: 5000}

          def presenta_nombre
            nombre
          end

        end # included

      end
    end
  end
end

