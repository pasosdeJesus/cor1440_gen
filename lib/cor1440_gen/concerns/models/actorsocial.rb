# encoding: UTF-8

require 'sip/concerns/models/actorsocial'

module Cor1440Gen
  module Concerns
    module Models
      module Actorsocial
        extend ActiveSupport::Concern

        included do
          include Sip::Concerns::Models::Actorsocial

          has_and_belongs_to_many :actividad, 
            class_name: 'Cor1440Gen::Actividad',
            foreign_key: "actorsocial_id", 
            association_foreign_key: 'actividad_id',
            join_table: 'cor1440_gen_actividad_actorsocial'

          #has_many :actividad_actorsocial, dependent: :delete_all,
          #  foreign_key: "actorsocial_id", validate: true,
          #  class_name: 'Cor1440Gen::ActividadActorsocial'
          #has_many :actividad, through: :actividad_actorsocial,
          #  class_name: 'Cor1440Gen::Actividad'

          has_many :actorsocial_efecto, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActorsocialEfecto'
          has_many :efecto, through: :actorsocial_efecto,
            class_name: 'Cor1440Gen::Efecto'

        end

      end
    end
  end
end
