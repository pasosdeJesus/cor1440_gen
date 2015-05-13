class CreaCombinadaProyectoProyectofinanciero < ActiveRecord::Migration
  def change
    create_join_table :proyecto, :proyectofinanciero, {
      table_name: 'cor1440_gen_proyecto_proyectofinanciero' 
    }
  end
end
