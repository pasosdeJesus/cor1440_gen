# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividadSipAnexo
        extend ActiveSupport::Concern

        included do

          self.table_name = 'cor1440_gen_actividad_sip_anexo'

          belongs_to :actividad, class_name: 'Cor1440Gen::Actividad',
            foreign_key: "actividad_id", validate: true,
            inverse_of: :actividad_sip_anexo
          belongs_to :sip_anexo, class_name: 'Sip::Anexo',
            foreign_key: "anexo_id", validate: true
          accepts_nested_attributes_for :sip_anexo, reject_if: :all_blank

          validates :actividad, presence: true
          validates :sip_anexo, presence: true
        end
      end
    end
  end
end

