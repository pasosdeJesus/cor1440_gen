class AgregaColumnafechaColumnaresponsableInforme < ActiveRecord::Migration[5.0]
  def change
    add_column :cor1440_gen_informe, :columnafecha, :boolean
    add_column :cor1440_gen_informe, :columnaresponsable, :boolean
  end
end
