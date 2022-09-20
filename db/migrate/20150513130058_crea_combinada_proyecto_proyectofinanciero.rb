class CreaCombinadaProyectoProyectofinanciero < ActiveRecord::Migration[4.2]
  def up
    create_join_table :proyecto, :proyectofinanciero
    rename_table :proyecto_proyectofinanciero, 
      'cor1440_gen_proyecto_proyectofinanciero'
  end

  def down
    drop_table 'cor1440_gen_proyecto_proyectofinanciero'
  end
end
