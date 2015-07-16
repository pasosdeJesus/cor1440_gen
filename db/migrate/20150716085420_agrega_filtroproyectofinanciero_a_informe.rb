class AgregaFiltroproyectofinancieroAInforme < ActiveRecord::Migration
  def change
    add_column :cor1440_gen_informe, :filtroproyectofinanciero, :integer

    add_foreign_key :cor1440_gen_informe, :cor1440_gen_proyectofinanciero, 
      column: :filtroproyectofinanciero
  end
end
