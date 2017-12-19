# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module Valorcampotind
        extend ActiveSupport::Concern

        included do
          include Sip::Modelo 

          belongs_to :campotind, class_name: '::Cor1440Gen::Campotind',
            foreign_key: 'campotind_id'

          validates :valor, length: { maximum: 5000}

        end # included
      end
    end
  end
end

