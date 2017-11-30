class AgregaTipoindicador < ActiveRecord::Migration[5.1]
  def change
    add_column :cor1440_gen_indicadorpf, :tipoindicador_id, :integer
    add_foreign_key :cor1440_gen_indicadorpf, :cor1440_gen_tipoindicador, column: :tipoindicador_id
  end
end
