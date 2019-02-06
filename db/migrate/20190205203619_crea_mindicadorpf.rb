class CreaMindicadorpf < ActiveRecord::Migration[5.2]
  def up
    if !table_exists? :cor1440_gen_mindicadorpf
      create_table :cor1440_gen_mindicadorpf do |t|
        t.integer :proyectofinanciero_id, null: false
        t.integer :indicadorpf_id, null: false
        t.string :formulacion, limit: 512
        t.string :frecuenciaanual, limit: 128
        t.string :descd1, string: 512
        t.string :descd2, string: 512
        t.string :descd3, string: 512
        t.float  :meta
        t.timestamp :created_at, null: false
        t.timestamp :updated_at, null: false
      end
    end
    add_foreign_key :cor1440_gen_mindicadorpf,  
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
    add_foreign_key :cor1440_gen_mindicadorpf,
      :cor1440_gen_indicadorpf, column: :indicadorpf_id
  end

  def down
    drop_table :cor1440_gen_mindicadorpf 
  end
end
