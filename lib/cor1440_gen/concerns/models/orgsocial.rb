# frozen_string_literal: true

require "msip/concerns/models/orgsocial"

module Cor1440Gen
  module Concerns
    module Models
      module Orgsocial
        extend ActiveSupport::Concern

        included do
          include Msip::Concerns::Models::Orgsocial

          has_and_belongs_to_many :actividad,
            class_name: "Cor1440Gen::Actividad",
            foreign_key: "orgsocial_id",
            association_foreign_key: "actividad_id",
            join_table: "cor1440_gen_actividad_orgsocial"

          # has_many :actividad_orgsocial, dependent: :delete_all,
          #  foreign_key: "orgsocial_id", validate: true,
          #  class_name: 'Cor1440Gen::ActividadOrgsocial'
          # has_many :actividad, through: :actividad_orgsocial,
          #  class_name: 'Cor1440Gen::Actividad'

          has_many :efecto_orgsocial,
            dependent: :delete_all,
            class_name: "Cor1440Gen::EfectoOrgsocial"
          has_many :efecto,
            through: :efecto_orgsocial,
            class_name: "Cor1440Gen::Efecto"

          def presenta_cor1440_gen(atr)
            presenta_msip(atr)
          end
        end
      end
    end
  end
end
