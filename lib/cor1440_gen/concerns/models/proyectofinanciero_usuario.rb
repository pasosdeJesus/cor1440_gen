module Cor1440Gen
  module Concerns
    module Models
      module ProyectofinancieroUsuario
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo
          include Sip::Localizacion
          include Sip::FormatoFechaHelper

          belongs_to :proyectofinanciero, 
            class_name: 'Cor1440Gen::Proyectofinanciero', 
            foreign_key: 'proyectofinanciero_id', optional: false
          belongs_to :usuario, class_name: '::Usuario',
            foreign_key: 'usuario_id', optional: true


        end # included

      end
    end
  end
end
