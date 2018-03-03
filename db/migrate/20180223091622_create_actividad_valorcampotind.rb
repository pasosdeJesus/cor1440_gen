class CreateActividadValorcampotind < ActiveRecord::Migration[5.1]
  def change
    create_table :cor1440_gen_actividad_valorcampotind do |t|
      t.integer :actividad_id
      t.integer :valorcampotind_id
    end
    add_foreign_key :cor1440_gen_actividad_valorcampotind, 
      :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :cor1440_gen_actividad_valorcampotind, 
      :cor1440_gen_valorcampotind, column: :valorcampotind_id
  end
end
