class RenombraActorsocialOrgsocial < ActiveRecord::Migration[6.1]
  def change
    if table_exists? :cor1440_gen_actividad_actorsocial
      rename_table  :cor1440_gen_actividad_actorsocial, :cor1440_gen_actividad_orgsocial
    end
    if table_exists? :cor1440_gen_actorsocial_efecto
      rename_table :cor1440_gen_actorsocial_efecto, :cor1440_gen_efecto_orgsocial
    end
    if column_exists? :cor1440_gen_asistencia, :actorsocial_id
      rename_column :cor1440_gen_asistencia, :actorsocial_id, :orgsocial_id
    end
    if column_exists? :cor1440_gen_asistencia, :perfilactorsocial_id
      rename_column :cor1440_gen_asistencia, :perfilactorsocial_id, :perfilorgsocial_id
    end
    if column_exists? :cor1440_gen_actividad_orgsocial, :actorsocial_id
      rename_column :cor1440_gen_actividad_orgsocial, :actorsocial_id, :orgsocial_id
    end
    if column_exists? :cor1440_gen_efecto_orgsocial, :actorsocial_id
      rename_column :cor1440_gen_efecto_orgsocial, :actorsocial_id, :orgsocial_id
    end
  end
end
