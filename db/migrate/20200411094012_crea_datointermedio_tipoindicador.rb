class CreaDatointermedioTipoindicador < ActiveRecord::Migration[6.0]
  def up
    create_table :cor1440_gen_datointermedioti do |t|
      t.string :nombre, limit: 1024, null: false
      t.integer :tipoindicador_id, null: false
    end
    add_foreign_key :cor1440_gen_datointermedioti, :cor1440_gen_tipoindicador,
      column: :tipoindicador_id
    execute <<-SQL
      SELECT setval('cor1440_gen_datointermedioti_id_seq', 1000);
    SQL
  end
  def down
    drop_table :cor1440_gen_datointermedioti
  end
end
