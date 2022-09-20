class ActividadActorsocialDeCinep < ActiveRecord::Migration[5.2]
  def up
    if table_exists? :actividad_actorsocial
      rename_table :actividad_actorsocial, :cor1440_gen_actividad_actorsocial
    elsif table_exists? :sip_actorsocial
      create_join_table :cor1440_gen_actividad, :sip_actorsocial
      rename_table :cor1440_gen_actividad_sip_actorsocial,
        'cor1440_gen_actividad_actorsocial'
      rename_column :cor1440_gen_actividad_actorsocial, 
        :cor1440_gen_actividad_id, :actividad_id
      rename_column :cor1440_gen_actividad_actorsocial, 
        :sip_actorsocial_id, :actorsocial_id
      add_foreign_key :cor1440_gen_actividad_actorsocial, 
        :cor1440_gen_actividad, column: :actividad_id
      add_foreign_key :cor1440_gen_actividad_actorsocial, 
        :sip_actorsocial,  column: :actorsocial_id
    else
      create_join_table :cor1440_gen_actividad, :sip_orgsocial
      rename_table :cor1440_gen_actividad_sip_orgsocial,
        'cor1440_gen_actividad_orgsocial'
      rename_column :cor1440_gen_actividad_orgsocial, 
        :cor1440_gen_actividad_id, :actividad_id
      rename_column :cor1440_gen_actividad_orgsocial, 
        :sip_orgsocial_id, :orgsocial_id
      add_foreign_key :cor1440_gen_actividad_orgsocial, 
        :cor1440_gen_actividad, column: :actividad_id
      add_foreign_key :cor1440_gen_actividad_orgsocial, 
        :sip_orgsocial,  column: :orgsocial_id
    end
  end
  def down
      rename_table :cor1440_gen_actividad_actorsocial, :actividad_actorsocial
  end
end
