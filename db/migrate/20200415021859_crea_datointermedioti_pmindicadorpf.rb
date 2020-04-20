class CreaDatointermediotiPmindicadorpf < ActiveRecord::Migration[6.0]
  def change
    create_table :cor1440_gen_datointermedioti_pmindicadorpf do |t|
      t.integer :datointermedioti_id, null: false
      t.integer :pmindicadorpf_id, null: false
      t.float :valor
      t.string :rutaevidencia, limit: 5000
    end
    add_index :cor1440_gen_datointermedioti_pmindicadorpf, 
      [:datointermedioti_id, :pmindicadorpf_id], unique: true,
     name: 'cor1440_gen_datointermedioti_pmindicadorpf_llaves_idx' 
    add_foreign_key :cor1440_gen_datointermedioti_pmindicadorpf, 
      :cor1440_gen_datointermedioti, column: :datointermedioti_id
    add_foreign_key :cor1440_gen_datointermedioti_pmindicadorpf, 
      :cor1440_gen_pmindicadorpf, column: :pmindicadorpf_id
  end
end
