class CreateActividadpf < ActiveRecord::Migration[5.0]
  def change
    create_table :actividadpf do |t|
      t.integer :proyectofinanciero_id
      t.string :nombrecorto, limit: 15
      t.string :titulo, limit: 255
      t.string :descripcion, limit: 5000
    end
    add_foreign_key :actividadpf, :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
    create_join_table :actividad, :actividadpf, {
      table_name: 'actividad_actividadpf' 
    }
    add_foreign_key :actividad_actividadpf, 
      :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :actividad_actividadpf, :actividadpf, 
      column: :actividadpf_id
  end
end
