# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividad
        extend ActiveSupport::Concern

        included do
          @current_usuario = -1
          attr_accessor :current_usuario

          has_many :actividadareas_actividad, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadareasActividad'
          has_many :actividadareas, through: :actividadareas_actividad,
            class_name: 'Cor1440Gen::Actividadarea'
          has_many :actividadtipo_actividad, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadtipoActividad'
          has_many :actividadtipo, through: :actividadtipo_actividad,
            class_name: 'Cor1440Gen::Actividadtipo'
 
          has_many :actividad_rangoedadac, foreign_key: "actividad_id", 
            dependent: :delete_all, class_name: 'Cor1440Gen::ActividadRangoedadac'
          has_many :rangoedadac, through: :actividad_rangoedadac,
            class_name: 'Cor1440Gen::Rangoedadac'
          accepts_nested_attributes_for :rangoedadac,  reject_if: :all_blank
          accepts_nested_attributes_for :actividad_rangoedadac, 
            allow_destroy: true, reject_if: :all_blank
          has_many :actividad_sip_anexo, foreign_key: "actividad_id", 
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::ActividadSipAnexo'
          has_many :sip_anexo, through: :actividad_sip_anexo,
            class_name: 'Sip::Anexo'
          accepts_nested_attributes_for :sip_anexo,  reject_if: :all_blank
          accepts_nested_attributes_for :actividad_sip_anexo, 
            allow_destroy: true, reject_if: :all_blank

          belongs_to :oficina, class_name: 'Sip::Oficina', 
            foreign_key: 'oficina_id', validate: true

          belongs_to :responsable, 
            class_name: '::Usuario', 
            foreign_key: 'usuario_id', validate: true

          validates_presence_of :oficina
          validates_presence_of :nombre
          validates_presence_of :fecha
        end
      end
    end
  end
end

