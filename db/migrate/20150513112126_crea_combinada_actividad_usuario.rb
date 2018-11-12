class CreaCombinadaActividadUsuario < ActiveRecord::Migration[4.2]
  def change
    create_join_table :actividad, :usuario, {
      table_name: 'cor1440_gen_actividad_usuario' 
    }
  end
end
