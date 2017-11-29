class CreateResultadopf < ActiveRecord::Migration[5.1]
  def change
    create_table :resultadopf do |t|
      t.integer :proyectofinanciero_id
      t.integer :objetivopf_id
      t.string :numero, limit: 15, null: false
      t.string :resultado, limit: 5000, null: false
    end
    add_foreign_key :resultadopf, :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
    add_foreign_key :resultadopf, :objetivopf, 
      column: :objetivopf_id
  end
end
