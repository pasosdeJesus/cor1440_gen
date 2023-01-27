class ReinstalaCalculoPoblacionCorr60 < ActiveRecord::Migration[7.0]

  def up
    Cor1440Gen::ConteosHelper.desinstala_calculo_poblacion_pg
    Cor1440Gen::ConteosHelper.instala_calculo_poblacion_pg
  end

  def down
  end
end
