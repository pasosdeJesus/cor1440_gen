class Informefinanciero < ActiveRecord::Migration[6.0]
  def change
    create_table :cor1440_gen_informefinanciero do |t|
      t.integer :proyectofinanciero_id, null: false
      t.string :detalle, limit: 5000
      t.date :fecha
      t.boolean :devoluciones
      t.string :seguimiento, limit: 5000

      t.timestamps null: false
    end
    add_foreign_key :cor1440_gen_informefinanciero, 
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
  end
end
