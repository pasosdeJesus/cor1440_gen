class CreaTablaUnionActividadProyecto < ActiveRecord::Migration[4.2]
  def change
    remove_column :cor1440_gen_actividad, :proyecto, :string, limit: 500
    create_table :cor1440_gen_actividad_proyecto do |t|
      t.integer :actividad_id
      t.integer :proyecto_id
    end
    add_foreign_key :cor1440_gen_actividad_proyecto, :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :cor1440_gen_actividad_proyecto, :cor1440_gen_proyecto, column: :proyecto_id
  end
end
