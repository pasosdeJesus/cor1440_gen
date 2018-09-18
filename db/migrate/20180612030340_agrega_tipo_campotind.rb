class AgregaTipoCampotind < ActiveRecord::Migration[5.2]
  def change
    add_column :cor1440_gen_campotind, :tipo, :integer, default: 1
  end
end
