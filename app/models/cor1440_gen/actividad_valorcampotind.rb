module Cor1440Gen
  class ActividadValorcampotind < ActiveRecord::Base
    belongs_to :actividad, class_name: 'Cor1440Gen::Actividad',
      foreign_key: 'actividad_id'
    belongs_to :valorcampotind, 
      class_name: 'Cor1440Gen::Valorcampotind', 
      foreign_key: 'valorcampotind_id', validate: true

    accepts_nested_attributes_for :valorcampotind, 
      reject_if: :all_blank 

    validates :actividad, presence: true
    #validates :valorcampotind, presence: true
  end
end
