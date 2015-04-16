# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadSipAnexo
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad'
          belongs_to :sip_anexo, class_name: 'Sip::Anexo'
        end
      end
    end
  end
end

