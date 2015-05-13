class ProyectoAProyectos < ActiveRecord::Migration
  def up
    execute <<-SQL
      INSERT INTO cor1440_gen_proyecto_proyectofinanciero 
        (proyecto_id, proyectofinanciero_id) 
        (SELECT proyecto_id, id FROM cor1440_gen_proyectofinanciero
         WHERE proyecto_id IS NOT NULL);
      ALTER TABLE cor1440_gen_proyectofinanciero 
        DROP COLUMN proyecto_id
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE cor1440_gen_proyectofinanciero 
        ADD COLUMN proyecto_id INTEGER;
      UPDATE cor1440_gen_proyectofinanciero SET
        proyecto_id=cor1440_gen_proyecto_proyectofinanciero.proyecto_id
        FROM cor1440_gen_proyecto_proyectofinanciero
        WHERE id=proyectofinanciero_id;
    SQL
  end
end
