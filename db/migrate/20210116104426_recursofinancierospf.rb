class Recursofinancierospf < ActiveRecord::Migration[6.0]
  def change
    add_column :cor1440_gen_proyectofinanciero, :tipomoneda_id, :integer
    add_foreign_key :cor1440_gen_proyectofinanciero, :cor1440_gen_tipomoneda, 
      column: :tipomoneda_id  
    add_column :cor1440_gen_proyectofinanciero, :saldoaejecutarp, :decimal, 
      precision: 20, scale: 2
    add_column :cor1440_gen_proyectofinanciero, :centrocosto, :string, 
      limit: 500

    add_column :cor1440_gen_proyectofinanciero, :tasaej, :float
    add_column :cor1440_gen_proyectofinanciero, :montoej, :float
    add_column :cor1440_gen_proyectofinanciero, :aportepropioej, :float
    add_column :cor1440_gen_proyectofinanciero, :aporteotrosej, :float
    add_column :cor1440_gen_proyectofinanciero, :presupuestototalej, :float
  end
end
