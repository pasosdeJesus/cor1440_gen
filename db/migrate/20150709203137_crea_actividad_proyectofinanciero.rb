class CreaActividadProyectofinanciero < ActiveRecord::Migration
  def change
    create_join_table :actividad, :proyectofinanciero, {
      table_name: 'cor1440_gen_actividad_proyectofinanciero' 
    }
    add_foreign_key :cor1440_gen_actividad_proyectofinanciero, 
      :cor1440_gen_actividad, column: :actividad_id
    add_foreign_key :cor1440_gen_actividad_proyectofinanciero, 
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
  end
end
