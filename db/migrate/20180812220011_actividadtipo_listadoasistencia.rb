class ActividadtipoListadoasistencia < ActiveRecord::Migration[5.2]
  def change
    if !Cor1440Gen::Actividadtipo.columns_hash['listadoasistencia']
      add_column :cor1440_gen_actividadtipo, :listadoasistencia, :bool
    end
  end
end
