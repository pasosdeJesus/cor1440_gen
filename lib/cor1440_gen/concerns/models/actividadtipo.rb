# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividadtipo
        extend ActiveSupport::Concern

        include Sip::Basica
        included do

          has_and_belongs_to_many :actividad, 
            class_name: 'Cor1440Gen::Actividadtipo',
            foreign_key: 'actividadtipo_id',
            association_foreign_key: 'actividad_id',
            join_table: 'cor1440_gen_actividad_actividadtipo'

          has_many :actividadpf, :dependent => :delete_all,
            class_name: 'Cor1440Gen::Actividadpf', 
            foreign_key: 'actividadtipo_id'


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

