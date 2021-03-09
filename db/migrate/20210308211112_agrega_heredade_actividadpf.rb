class AgregaHeredadeActividadpf < ActiveRecord::Migration[6.1]
  def up
    if !Cor1440Gen::Actividadpf.has_attribute?(:heredade_id)
      add_column :cor1440_gen_actividadpf, :heredade_id, :integer
      add_foreign_key :cor1440_gen_actividadpf, :cor1440_gen_actividadpf,
        column: :heredade_id
    end
  end
  def down
    remove_column :cor1440_gen_actividadpf, :heredade_id, :integer
  end

end
