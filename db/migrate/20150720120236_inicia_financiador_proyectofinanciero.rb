class IniciaFinanciadorProyectofinanciero < ActiveRecord::Migration
  def up
    execute <<-SQL
      INSERT INTO cor1440_gen_financiador_proyectofinanciero 
        (financiador_id, proyectofinanciero_id)
        (SELECT financiador_id, id FROM cor1440_gen_proyectofinanciero
         WHERE financiador_id IS NOT NULL);
      ALTER TABLE cor1440_gen_proyectofinanciero DROP COLUMN financiador_id;
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE cor1440_gen_proyectofinanciero ADD COLUMN financiador_id INTEGER;
      UPDATE cor1440_gen_proyectofinanciero SET 
        financiador_id=cor1440_gen_financiador_proyectofinanciero.financiador_id
        FROM cor1440_gen_financiador_proyectofinanciero
        WHERE id=proyectofinanciero_id;
      DELETE FROM cor1440_gen_financiador_proyectofinanciero;
    SQL
  end
end
