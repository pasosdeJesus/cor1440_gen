class CreaCombinadaActividadUsuario < ActiveRecord::Migration
  def change
    create_join_table :actividad, :usuario, {
      table_name: 'cor1440_gen_actividad_usuario' 
    }
  end
end
