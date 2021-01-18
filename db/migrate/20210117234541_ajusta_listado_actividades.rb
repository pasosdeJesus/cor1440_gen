class AjustaListadoActividades < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      DELETE FROM heb412_gen_campoplantillahcm WHERE id=514;
      UPDATE heb412_gen_campoplantillahcm SET
        columna='O' WHERE id=515;
      UPDATE heb412_gen_campoplantillahcm SET
        columna='P' WHERE id=516;
    SQL
  end

  def down
    execute <<-SQL
      UPDATE heb412_gen_campoplantillahcm SET
        columna='Q' WHERE id=516;
      UPDATE heb412_gen_campoplantillahcm SET
        columna='P' WHERE id=515;
      INSERT INTO heb412_gen_campoplantillahcm 
        (id, plantillahcm_id, nombrecampo, cocumna) VALUES
        (512, 5, 'observaciones', 'O');
    SQL
  end
end
