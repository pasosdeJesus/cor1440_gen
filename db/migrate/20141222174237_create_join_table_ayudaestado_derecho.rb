class CreateJoinTableAyudaestadoDerecho < ActiveRecord::Migration
  def change
    create_table :cor1440_gen_ayudaestado_derecho, id:false do |t|
      t.column :ayudaestado_id, :integer
      t.column :derecho_id, :integer
    end
    add_foreign_key :cor1440_gen_ayudaestado_derecho, :cor1440_gen_ayudaestado,
      column: :ayudaestado_id
    add_foreign_key :cor1440_gen_ayudaestado_derecho, :cor1440_gen_derecho,
      column: :derecho_id
  end
end
