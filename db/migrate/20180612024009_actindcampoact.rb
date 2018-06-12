class Actindcampoact < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      SELECT setval('cor1440_gen_campoact_id_seq', MAX(id)+1) FROM cor1440_gen_campoact;    
      SELECT setval('cor1440_gen_campotind_id_seq', MAX(id)+1) FROM cor1440_gen_campotind;    
    SQL
  end

  def down
  end
end
