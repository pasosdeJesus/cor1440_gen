class MontoEnterogrande < ActiveRecord::Migration[6.0]
  def up
    change_column :cor1440_gen_proyectofinanciero, :monto, :decimal
  end
  def down
    change_column :cor1440_gen_proyectofinanciero, :monto, :integer
  end
end
