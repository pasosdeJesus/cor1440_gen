class AgregaFormulaDintermedio < ActiveRecord::Migration[6.1]
  def change
    add_column :cor1440_gen_datointermedioti, :nombreinterno, :string, limit: 127 
    add_column :cor1440_gen_datointermedioti, :filtro, :string, limit: 5000
    add_column :cor1440_gen_datointermedioti, :funcion, :string, limit: 5000
  end
end
