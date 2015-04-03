class EliminaDerechoDeTablas < ActiveRecord::Migration
  def change
    remove_column :cor440_gen_ayudaestado, :derecho_id, :integer
    remove_column :cor440_gen_ayudasjr, :derecho_id, :integer
    remove_column :cor440_gen_motivosjr, :derecho_id, :integer
    remove_column :cor440_gen_progestado, :derecho_id, :integer
  end
end
