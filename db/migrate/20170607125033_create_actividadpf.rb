class CreateActividadpf < ActiveRecord::Migration[5.0]
  def up
    create_table :actividadpf do |t|
      t.integer :proyectofinanciero_id
      t.string :nombrecorto, limit: 15
      t.string :titulo, limit: 255
      t.string :descripcion, limit: 5000
    end
    add_foreign_key :actividadpf, :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
    create_join_table :actividad, :actividadpf
    add_foreign_key :actividad_actividadpf, 
      :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :actividad_actividadpf, :actividadpf, 
      column: :actividadpf_id
  end

  def down
    drop_table :actividad_actividadpf
    drop_table :actividadpf
  end
end
