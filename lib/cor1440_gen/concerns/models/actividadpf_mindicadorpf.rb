# encoding: UTF-8

module Cor1440Gen
  module Concerns
    module Models
      module ActividafpfMindicadorpf
        extend ActiveSupport::Concern

        included do

          belongs_to :actividadpf, class_name: 'Cor1440Gen::Actividadpf',
            foreign_key: 'actividadpf_id'
          belongs_to :mindicadorpf, class_name: 'Cor1440Gen::Mindicadorpf',
            foreign_key: 'mindicadorpf_id'

        end
      end
    end
  end
end

