class CreateIndicadorpf < ActiveRecord::Migration[5.1]
  def change
    create_table :indicadorpf do |t|
      t.integer :proyectofinanciero_id
      t.integer :resultadopf_id
      t.string :numero, limit: 15, null: false
      t.string :indicador, limit: 5000, null: false
    end
    add_foreign_key :indicadorpf, :resultadopf,
      column: :resultadopf_id
    add_foreign_key :indicadorpf, :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
  end
end
