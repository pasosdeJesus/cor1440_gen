# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividadtipo
        extend ActiveSupport::Concern

        include Sip::Basica
        included do

          has_many :actividad_actividadtipo, :dependent => :delete_all,
            class_name: 'Cor1440Gen::ActividadActividadtipo'
          has_many :actividad, :through => :actividad_actividadtipo,
            class_name: 'Cor1440Gen::Actividadtipo'

          has_many :campoact, foreign_key: 'actividadtipo_id',
            validate: true, dependent: :destroy,
            class_name: 'Cor1440Gen::Campoact'
          accepts_nested_attributes_for :campoact,
            allow_destroy: true, reject_if: :all_blank


        end
      end
    end
  end
end

