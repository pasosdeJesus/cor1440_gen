class CreateCor1440GenValorcampoact < ActiveRecord::Migration[5.1]
  def change
    create_table :cor1440_gen_valorcampoact do |t|
      t.integer :actividad_id
      t.integer :campoact_id
      t.string :valor, limit: 5000
    end
    add_foreign_key :cor1440_gen_valorcampoact, :cor1440_gen_actividad,
      column: :actividad_id
    add_foreign_key :cor1440_gen_valorcampoact, :cor1440_gen_campoact,
      column: :campoact_id
  end
end
