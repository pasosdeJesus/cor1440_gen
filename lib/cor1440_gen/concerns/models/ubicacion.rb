# encoding: UTF-8

require 'sip/concerns/models/ubicacion'

module Cor1440Gen
  module Concerns
    module Models
      module Ubicacion
        extend ActiveSupport::Concern
        include Sip::Concerns::Models::Ubicacion

        included do
          #has_many :llegada, class_name: "Cor1440Gen::Desplazamiento", 
          #  foreign_key: "id_llegada", validate: true, dependent: :destroy
        end

        module ClassMethods
        end

      end
    end
  end
end
