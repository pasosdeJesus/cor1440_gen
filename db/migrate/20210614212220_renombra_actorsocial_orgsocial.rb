class RenombraActorsocialOrgsocial < ActiveRecord::Migration[6.1]
  def change
    rename_table :cor1440_gen_actividad_actorsocial, :cor1440_gen_actividad_orgsocial
    rename_table :cor1440_gen_actorsocial_efecto, :cor1440_gen_efecto_orgsocial
    rename_column :cor1440_gen_asistencia, :actorsocial_id, :orgsocial_id
    rename_column :cor1440_gen_asistencia, :perfilactorsocial_id, :perfilorgsocial_id
    rename_column :cor1440_gen_actividad_orgsocial, :actorsocial_id, :orgsocial_id
    rename_column :cor1440_gen_efecto_orgsocial, :actorsocial_id, :orgsocial_id

  end
end
