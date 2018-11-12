class AregaProyectofinancieroCompromisos < ActiveRecord::Migration[4.2]
  def change
    add_column :cor1440_gen_proyectofinanciero, :compromisos, :string, limit: 5000
  end
end
