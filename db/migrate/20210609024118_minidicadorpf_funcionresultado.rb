class MinidicadorpfFuncionresultado < ActiveRecord::Migration[6.1]
  def change
    add_column :cor1440_gen_mindicadorpf, :funcionresultado, 
      :string, limit: 5000
  end
end
