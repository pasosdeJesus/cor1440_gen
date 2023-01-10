# frozen_string_literal: true

class CreaCor1440ActividadActorsocial < ActiveRecord::Migration[5.2]
  def change
    create_join_table(:cor1440_gen_actividad, :msip_actorsocial, {
      table_name: "cor1440_gen_actividad_actorsocial",
    })
    add_foreign_key(
      :cor1440_gen_actividad_actorsocial,
      :cor1440_gen_actividad,
      column: :cor1440_gen_actividad_id,
    )
    add_foreign_key(
      :cor1440_gen_actividad_actorsocial,
      :msip_actorsocial,
      column: :msip_actorsocial_id,
    )
    rename_column(
      :cor1440_gen_actividad_actorsocial,
      :msip_actorsocial_id,
      :actorsocial_id,
    )
    rename_column(
      :cor1440_gen_actividad_actorsocial,
      :cor1440_gen_actividad_id,
      :actividad_id,
    )
  end
end
