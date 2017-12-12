class CreateCor1440GenCampotind < ActiveRecord::Migration[5.1]
  def change
    create_table :cor1440_gen_campotind do |t|
      t.integer :tipoindicador_id, null: false
      t.string :nombrecampo, limit: 128, null: false
      t.string :ayudauso, limit: 1024
    end
    add_foreign_key :cor1440_gen_campotind, :cor1440_gen_tipoindicador,
      column: :tipoindicador_id
  end
end
