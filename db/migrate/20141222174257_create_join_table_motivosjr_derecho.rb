class CreateJoinTableMotivosjrDerecho < ActiveRecord::Migration
  def change
    create_table :cor440_gen_motivosjr_derecho, id:false do |t|
      t.column :motivosjr_id, :integer
      t.column :derecho_id, :integer
    end
    add_foreign_key :cor440_gen_motivosjr_derecho, :cor440_gen_motivosjr,
      column: :motivosjr_id
    add_foreign_key :cor440_gen_motivosjr_derecho, :cor440_gen_derecho,
      column: :derecho_id
  end
end
