class CreateObjetivopf < ActiveRecord::Migration[5.1]
  def change
    create_table :objetivopf do |t|
      t.integer :proyectofinanciero_id
      t.string :numero, limit: 15, null: false
      t.string :objetivo, limit: 5000, null: false
    end
    add_foreign_key :objetivopf, :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
  end
end
