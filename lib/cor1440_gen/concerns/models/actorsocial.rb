# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Actorsocial
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 
          include Sip::Localizacion
          include Sip::Basica

          self.table_name = 'cor1440_gen_actorsocial'

          belongs_to :pais, class_name: 'Sip::Pais',
            foreign_key: "pais_id", validate: true

          validates :cargo, length: { maximum: 500 }
          validates :correo, length: { maximum: 500 }
          validates :telefono, length: { maximum: 500 }
          validates :fax, length: { maximum: 500 }
          validates :direccion, length: { maximum: 500 }

          def presenta(atr)
            case atr.to_s
            when "pais_id" 
              self[atr] ? Sip::Pais.find(self[atr]).nombre : ""
            else
              presenta_gen(atr)
            end
          end

        end

      end
    end
  end
end
