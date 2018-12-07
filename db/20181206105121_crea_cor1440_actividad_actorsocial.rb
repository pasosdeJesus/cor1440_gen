class CreaCor1440ActividadActorsocial < ActiveRecord::Migration[5.2]
  def change
    create_join_table :cor1440_gen_actividad, :sip_actorsocial, {
      table_name: 'cor1440_gen_actividad_actorsocial' 
    }
    add_foreign_key :cor1440_gen_actividad_actorsocial, 
      :cor1440_gen_actividad, column: :cor1440_gen_actividad_id
    add_foreign_key :cor1440_gen_actividad_actorsocial, 
      :sip_actorsocial, column: :sip_actorsocial_id
    rename_column :cor1440_gen_actividad_actorsocial, :sip_actorsocial_id,
      :actorsocial_id
    rename_column :cor1440_gen_actividad_actorsocial, :cor1440_gen_actividad_id,
      :actividad_id
  end
end
