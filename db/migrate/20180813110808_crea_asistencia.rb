class CreaAsistencia < ActiveRecord::Migration[5.2]
  def change
    create_table :cor1440_gen_asistencia do |t|
      t.integer :actividad_id, null: false
      t.integer :persona_id, null: false
      t.integer :rangoedadac_id
      t.boolean    :externo
      t.integer :actorsocial_id
      t.integer :perfilactorsocial_id
    end
  end
end
