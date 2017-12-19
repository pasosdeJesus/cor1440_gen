class CreateCor1440GenValorcampotind < ActiveRecord::Migration[5.1]
  def change
    create_table :cor1440_gen_valorcampotind do |t|
      t.integer :campotind_id
      t.string :valor, limit: 5000
    end
    add_foreign_key :cor1440_gen_valorcampotind, :cor1440_gen_campotind, 
      column: :campotind_id
  end
end
