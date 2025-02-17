# frozen_string_literal: true

class InstalaCalculoPoblacionEnPostgres < ActiveRecord::Migration[7.0]
  def up
    Cor1440Gen::ConteosHelper.instala_calculo_poblacion_pg
  end

  def down
    Cor1440Gen::ConteosHelper.desinstala_calculo_poblacion_pg
  end
end
