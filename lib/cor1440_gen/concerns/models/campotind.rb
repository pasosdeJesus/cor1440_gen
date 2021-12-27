module Cor1440Gen
  module Concerns
    module Models
      module Campotind
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 

          belongs_to :tipoindicador, class_name: 'Cor1440Gen::Tipoindicador',
            foreign_key: 'tipoindicador_id', optional: false

          has_many :valorcampotind, 
            class_name: 'Cor1440Gen::Valorcampotind',
            foreign_key: 'campotind_id',
            dependent: :delete_all

          validates :nombrecampo, length: { maximum: 128}
          validates :ayudauso, length: { maximum: 1024}

        end # included
      end
    end
  end
end

