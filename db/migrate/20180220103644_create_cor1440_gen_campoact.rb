class CreateCor1440GenCampoact < ActiveRecord::Migration[5.1]
  def change
    create_table :cor1440_gen_campoact do |t|
      t.integer :actividadtipo_id
      t.string :nombrecampo, limit: 128
      t.string :ayudauso, limit: 1024
    end
    add_foreign_key :cor1440_gen_campoact, :cor1440_gen_actividadtipo, 
      column: :actividadtipo_id
  end
end
