class AgregaTipoCampoact < ActiveRecord::Migration[5.2]
  def change
    add_column :cor1440_gen_campoact, :tipo, :integer, default: 1
    # 1 - texto corto
    # 2 - texto largo
    # 3 - entero
    # 4 - booleano
  end
end
