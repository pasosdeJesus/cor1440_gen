class AgregaLugarAActividad < ActiveRecord::Migration[4.2]
  def change
    add_column :cor1440_gen_actividad, :lugar, :string, limit: 500
  end
end
