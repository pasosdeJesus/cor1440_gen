# encoding: UTF-8

module Cor1440Gen
  class Datointermedioti < ActiveRecord::Base

    belongs_to :tipoindicador, class_name: 'Cor1440Gen::Tipoindicador',
      foreign_key: 'tipoindicador_id'

    validates :nombre, length: { maximum: 1024}

    def presenta_nombre
      nombre
    end
  end
end
