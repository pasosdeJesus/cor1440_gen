class ActividadtipoListadoasistencia < ActiveRecord::Migration[5.2]
  def change
    add_column :cor1440_gen_actividadtipo, :listadoasistencia, :bool
  end
end
