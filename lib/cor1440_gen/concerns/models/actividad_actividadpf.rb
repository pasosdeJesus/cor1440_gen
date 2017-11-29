# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadActividadpf
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad', 
            foreign_key: 'actividad_id'
          belongs_to :actividadpf, class_name: 'Cor1440Gen::Actividadpf',
            foreign_key: 'actividadpf_id'
        end # included

      end
    end
  end
end



