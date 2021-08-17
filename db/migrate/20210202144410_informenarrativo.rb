class Informenarrativo < ActiveRecord::Migration[6.0]
  def change
    create_table :cor1440_gen_informenarrativo do |t|
      t.integer :proyectofinanciero_id, null: false
      t.string :detalle, limit: 5000
      t.date :fecha
      t.boolean :devoluciones
      t.string :seguimiento, limit: 5000

      t.timestamps null: false
    end
    add_foreign_key :cor1440_gen_informenarrativo, 
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
  end
end
