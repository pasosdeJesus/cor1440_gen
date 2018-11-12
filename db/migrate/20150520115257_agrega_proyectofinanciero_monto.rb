class AgregaProyectofinancieroMonto < ActiveRecord::Migration[4.2]
  def change
    add_column :cor1440_gen_proyectofinanciero, :monto, :integer
  end
end
