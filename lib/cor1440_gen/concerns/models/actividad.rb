# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividad
        extend ActiveSupport::Concern

        included do
          @current_usuario = -1
          attr_accessor :current_usuario

          belongs_to :oficina, class_name: 'Sip::Oficina', 
            foreign_key: 'oficina_id', validate: true

          belongs_to :responsable, 
            class_name: '::Usuario', 
            foreign_key: 'usuario_id', validate: true

          has_many :actividadareas_actividad, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadareasActividad',
            foreign_key: 'actividad_id'
          has_many :actividadareas, through: :actividadareas_actividad,
            class_name: 'Cor1440Gen::Actividadarea'

          has_many :actividad_actividadtipo, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadActividadtipo',
            foreign_key: 'actividad_id'
          has_many :actividadtipo, through: :actividad_actividadtipo,
            class_name: 'Cor1440Gen::Actividadtipo'

          has_many :actividad_proyecto, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadProyecto',
            foreign_key: 'actividad_id'
          has_many :proyecto, through: :actividad_proyecto,
            class_name: 'Cor1440Gen::Proyecto'

          has_many :actividad_rangoedadac, foreign_key: "actividad_id", 
            dependent: :delete_all, 
            class_name: 'Cor1440Gen::ActividadRangoedadac'
          has_many :rangoedadac, through: :actividad_rangoedadac,
            class_name: 'Cor1440Gen::Rangoedadac'
          accepts_nested_attributes_for :rangoedadac,  reject_if: :all_blank
          accepts_nested_attributes_for :actividad_rangoedadac, 
            allow_destroy: true, reject_if: :all_blank

          has_many :actividad_sip_anexo, foreign_key: "actividad_id", 
            validate: true, dependent: :destroy, 
            class_name: 'Cor1440Gen::ActividadSipAnexo',
            inverse_of: :actividad
          accepts_nested_attributes_for :actividad_sip_anexo, 
            allow_destroy: true, reject_if: :all_blank
          has_many :sip_anexo, through: :actividad_sip_anexo,
            class_name: 'Sip::Anexo'
          accepts_nested_attributes_for :sip_anexo, 
            reject_if: :all_blank

          has_many :actividad_usuario, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadUsuario',
            foreign_key: 'actividad_id'
          has_many :usuario, through: :actividad_usuario,
            class_name: 'Usuario'

          validates_presence_of :oficina
          validates_presence_of :fecha
          validates :nombre, presence: true, allow_blank: false, 
            length: { maximum: 500 } 
          validates :objetivo, length: { maximum: 5000 } 
          validates :resultado, length: { maximum: 5000 } 
          validates :observaciones, length: { maximum: 5000 } 
        end
      end
    end
  end
end

