# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Proyectofinanciero
        extend ActiveSupport::Concern
        include Sip::Basica

        included do
          belongs_to :financiador, class_name: 'Cor1440Gen::Financiador',
            foreign_key: "financiador_id", validate: true
          belongs_to :proyecto, class_name: 'Cor1440Gen::Proyecto',
            foreign_key: "proyecto_id", validate: true
          belongs_to :responsable, class_name: 'Usuario',
            foreign_key: "responsable_id", validate: true

          validates :nombre, presence: true, allow_blank: false
          validates :fechacreacion, presence: true, allow_blank: false
        end
      end
    end
  end
end
