class AgregaProyectofinancieroMonto < ActiveRecord::Migration
  def change
    add_column :cor1440_gen_proyectofinanciero, :monto, :integer
  end
end
