class CreaIndicadorEf10 < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
    INSERT INTO cor1440_gen_tipoindicador (id, nombre, esptipometa,
      medircon, fechacreacion, created_at, updated_at) VALUES (
      '10', 'CUENTA EFECTOS', 'Número de efectos', 
      2, '2020-08-10', '2020-08-10', '2020-08-10');
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM cor1440_gen_tipoindicador WHERE id='10';
    SQL
  end
end
