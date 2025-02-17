# frozen_string_literal: true

module Cor1440Gen
  module Concerns
    module Models
      module ProyectofinancieroUsuario
        extend ActiveSupport::Concern

        included do
          include Msip::Modelo
          include Msip::Localizacion
          include Msip::FormatoFechaHelper

          belongs_to :proyectofinanciero,
            class_name: "Cor1440Gen::Proyectofinanciero",
            optional: false
          belongs_to :usuario,
            class_name: "::Usuario",
            optional: true

          validates :usuario_id, uniqueness: {
            allow_blank: true,
            message: "Funcionario repetido",
            scope: :proyectofinanciero_id,
          }

          # validate :no_repite_funcionario
          # def no_repite_funcionario
          #  debugger
          # end
        end # included
      end
    end
  end
end
