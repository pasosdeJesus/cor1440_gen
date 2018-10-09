class CreaCombinadaProyectoProyectofinanciero < ActiveRecord::Migration[4.2]
  def change
    create_join_table :proyecto, :proyectofinanciero, {
      table_name: 'cor1440_gen_proyecto_proyectofinanciero' 
    }
  end
end
