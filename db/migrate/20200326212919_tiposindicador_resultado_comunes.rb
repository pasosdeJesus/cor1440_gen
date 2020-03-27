class TiposindicadorResultadoComunes < ActiveRecord::Migration[6.0]
  def up
    execute <<-SQL
      INSERT INTO cor1440_gen_tipoindicador 
      (id, nombre, fechacreacion, created_at, updated_at ) VALUES 
      (1, 'CUENTA ACTIVIDADES', '2020-03-26', '2020-03-26', '2020-03-26');
      INSERT INTO cor1440_gen_tipoindicador 
      (id, nombre, fechacreacion, created_at, updated_at ) VALUES 
      (2, 'CUENTA POBLACIÓN ACT', '2020-03-26', '2020-03-26', '2020-03-26');
      INSERT INTO cor1440_gen_tipoindicador 
      (id, nombre, fechacreacion, created_at, updated_at ) VALUES 
      (3, 'CUENTA ASISTENTES ACT', '2020-03-26', '2020-03-26', '2020-03-26');
    SQL
  end

  def down
    execute <<-SQL
      DELETE FROM cor1440_gen_tipoindicador WHERE id>='1' AND id<='3';
    SQL
  end
end
