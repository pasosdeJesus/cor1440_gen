class AgregaLugarAActividad < ActiveRecord::Migration
  def change
    add_column :cor1440_gen_actividad, :lugar, :string, limit: 500
  end
end
