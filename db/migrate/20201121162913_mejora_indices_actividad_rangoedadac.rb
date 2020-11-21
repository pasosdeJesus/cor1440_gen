class MejoraIndicesActividadRangoedadac < ActiveRecord::Migration[6.0]
  def up
    if Cor1440Gen::ActividadRangoedadac.primary_key.nil?
      execute <<-SQL
        ALTER TABLE cor1440_gen_actividad_rangoedadac ADD PRIMARY KEY(id);
      SQL
    end
    if !foreign_key_exists?(
        :cor1440_gen_actividad_rangoedadac, 
        :cor1440_gen_actividad, column: :actividad_id)
      add_foreign_key :cor1440_gen_actividad_rangoedadac,
        :cor1440_gen_actividad, column: :actividad_id
    end
    if !foreign_key_exists?(
        :cor1440_gen_actividad_rangoedadac, 
        :cor1440_gen_rangoedadac, column: :rangoedadac_id)
      add_foreign_key :cor1440_gen_actividad_rangoedadac,
        :cor1440_gen_rangoedadac, column: :rangoedadac_id
    end
  end

  def down
  end
end
