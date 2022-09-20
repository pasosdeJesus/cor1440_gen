class CreaActividadProyectofinanciero < ActiveRecord::Migration[4.2]
  def up
    create_join_table :actividad, :proyectofinanciero
    rename_table :actividad_proyectofinanciero, 'cor1440_gen_actividad_proyectofinanciero'
    add_foreign_key :cor1440_gen_actividad_proyectofinanciero, 
      :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :cor1440_gen_actividad_proyectofinanciero, 
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
  end
  def down
    drop_table 'cor1440_gen_actividad_proyectofinanciero'
  end
end
