class CreaCor1440GenActividadpfMindicadorpf < ActiveRecord::Migration[6.0]
  def change
    create_table :cor1440_gen_actividadpf_mindicadorpf, id: false do |t|
      t.integer :actividadpf_id
      t.integer :mindicadorpf_id
      t.index :actividadpf_id
      t.index :mindicadorpf_id
    end
    add_foreign_key :cor1440_gen_actividadpf_mindicadorpf, 
      :cor1440_gen_actividadpf, column: :actividadpf_id
    add_foreign_key :cor1440_gen_actividadpf_mindicadorpf, 
      :cor1440_gen_mindicadorpf, column: :mindicadorpf_id
  end

end
