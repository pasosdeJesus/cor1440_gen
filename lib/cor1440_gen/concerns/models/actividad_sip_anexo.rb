# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadSipAnexo
        extend ActiveSupport::Concern

        included do
          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad',
            foreign_key: "actividad_id"
          belongs_to :sip_anexo, class_name: 'Sip::Anexo',
            foreign_key: "anexo_id"
          accepts_nested_attributes_for :sip_anexo, reject_if: :all_blank
        end
      end
    end
  end
end

