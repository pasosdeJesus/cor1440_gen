# frozen_string_literal: true

class SimplificaActividadSinRangoedadac < ActiveRecord::Migration[7.2]
  def change
    remove_column(:cor1440_gen_actividad, :rangoedadac_id, :integer)
  end
end
