class CreateJoinTableAyudasjrDerecho < ActiveRecord::Migration
  def change
    create_table :cor440_gen_ayudasjr_derecho, id:false do |t|
      t.column :ayudasjr_id, :integer
      t.column :derecho_id, :integer
    end
    add_foreign_key :cor440_gen_ayudasjr_derecho, :cor440_gen_ayudasjr,
      column: :ayudasjr_id
    add_foreign_key :cor440_gen_ayudasjr_derecho, :cor440_gen_derecho,
      column: :derecho_id
  end
end
