# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Campotind
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 

          belongs_to :tipoindicador, class_name: 'Cor1440Gen::Tipoindicador',
            foreign_key: 'tipoindicador_id'

          validates :nombrecampo, length: { maximum: 128}
          validates :ayudauso, length: { maximum: 1024}

        end # included
      end
    end
  end
end

