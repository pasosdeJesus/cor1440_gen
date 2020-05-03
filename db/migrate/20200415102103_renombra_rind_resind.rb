class RenombraRindResind < ActiveRecord::Migration[6.0]
  def change
    rename_column :cor1440_gen_pmindicadorpf, :rind, :resind
    rename_column :cor1440_gen_pmindicadorpf, :urlevrind, :rutaevidencia
  end
end
