class CreateJoinTableProgestadoDerecho < ActiveRecord::Migration
  def change
    create_table :cor440_gen_progestado_derecho, id:false do |t|
      t.column :progestado_id, :integer
      t.column :derecho_id, :integer
    end
    add_foreign_key :cor440_gen_progestado_derecho, :cor440_gen_progestado,
      column: :progestado_id
    add_foreign_key :cor440_gen_progestado_derecho, :cor440_gen_derecho,
      column: :derecho_id
  end
end
