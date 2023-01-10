# frozen_string_literal: true

require "msip/concerns/models/anexo"

module Cor1440Gen
  module Concerns
    module Models
      module Anexo
        extend ActiveSupport::Concern
        include Msip::Concerns::Models::Anexo

        included do
          has_many :actividad_anexo,
            foreign_key: "anexo_id",
            validate: true,
            class_name: "Cor1440Gen::ActividadAnexo"
          has_many :actividad,
            class_name: "Cor1440Gen::Actividad",
            through: :actividad_anexo
        end

        module ClassMethods
        end
      end
    end
  end
end
