class AgregaFiltrosInforme < ActiveRecord::Migration
  def change
    add_column :cor1440_gen_informe, :filtroresponsable, :integer
    add_column :cor1440_gen_informe, :filtrooficina, :integer
    add_foreign_key :cor1440_gen_informe, :usuario, column: :filtroresponsable
    add_foreign_key :cor1440_gen_informe, :sip_oficina, column: :filtrooficina
  end
end
