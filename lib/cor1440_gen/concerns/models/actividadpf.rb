# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actividadpf
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper

          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero',
            foreign_key: 'proyectofinanciero_id'
          belongs_to :resultadopf, 
            class_name: 'Cor1440Gen::Resultadopf',
            foreign_key: 'resultadopf_id'
          belongs_to :actividadtipo, 
            class_name: 'Cor1440Gen::Actividadtipo',
            foreign_key: 'actividadtipo_id'


          has_many :actividad_actividadpf, dependent: :delete_all,
            class_name: 'Cor1440Gen::ActividadActividadpf', foreign_key: 'actividadpf_id'
          has_many :actividad, through: :actividad_actividadpf,
            class_name: 'Cor1440Gen::Actividad'

          validates :nombrecorto, presence: true, length: {maximum: 15}
          validates :titulo, length: {maximum: 255}
          validates :descripcion, length: {maximum: 5000}

          def presenta_nombre
            nombrecorto + ":" + titulo
          end
        end # included

      end
    end
  end
end

