class AregaProyectofinancieroCompromisos < ActiveRecord::Migration
  def change
    add_column :cor1440_gen_proyectofinanciero, :compromisos, :string, limit: 5000
  end
end
