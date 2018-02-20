class AgregaActividadtipoAActividadpf < ActiveRecord::Migration[5.1]
  def change
    add_column :cor1440_gen_actividadpf, :actividadtipo_id, :integer
    add_foreign_key :cor1440_gen_actividadpf, :cor1440_gen_actividadtipo, 
      column: :actividadtipo_id
  end
end
