class CreaCombinadaActividadUsuario < ActiveRecord::Migration[4.2]
  def up
    create_join_table :actividad, :usuario
    rename_table :actividad_usuario, :cor1440_gen_actividad_usuario
  end
  def down
    drop_table :cor1440_gen_actividad_usuario
  end
end
