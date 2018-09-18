class ActualizaLlaveActividadpf < ActiveRecord::Migration[5.2]
  def up
    execute <<-SQL
      SELECT setval('cor1440_gen_actividadpf_id_seq', MAX(id)+1) FROM cor1440_gen_actividadpf;
    SQL
  end
  def down
  end
end
