module Cor1440Gen
  module Concerns
    module Models
      module OrgsocialEfecto
        extend ActiveSupport::Concern

        included do

          belongs_to :orgsocial, class_name: 'Sip::Orgsocial',
            foreign_key: 'orgsocial_id'
          belongs_to :efecto, class_name: 'Cor1440Gen::Efecto',
            foreign_key: 'efecto_id'
        end

      end
    end
  end
end

