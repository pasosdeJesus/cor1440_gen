class AgregaFormularioAActividadpf < ActiveRecord::Migration[6.1]
  def change
    add_column :cor1440_gen_actividadpf, :formulario_id, :integer
    add_foreign_key :cor1440_gen_actividadpf,
      :mr519_gen_formulario, column: :formulario_id
  end
end
