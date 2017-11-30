class CreateCor1440GenTipoindicador < ActiveRecord::Migration[5.1]
  def change
    create_table :cor1440_gen_tipoindicador do |t|
      t.string :nombre, limit: 32
      t.integer :medircon#1 actividades/servicios, #2 efectos
      t.string :espcampos, limit: 1000
      t.string :espvaloresomision, limit: 1000
      t.string :espvalidaciones, limit: 1000
      t.string :esptipometa, limit: 32
      t.string :espfuncionmedir, limit: 1000
    end
  end
end
