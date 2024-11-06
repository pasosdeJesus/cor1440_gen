class SimplificaCampoact < ActiveRecord::Migration[7.2]
  def up
    drop_table :cor1440_gen_valorcampoact
    drop_table :cor1440_gen_campoact
  end
end
