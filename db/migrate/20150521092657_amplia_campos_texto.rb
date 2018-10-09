class AmpliaCamposTexto < ActiveRecord::Migration[4.2]
  def change
    change_column :cor1440_gen_actividad, :objetivo, :string, :limit => 5000
    change_column :cor1440_gen_actividad, :resultado, :string, :limit => 5000
  end
end
