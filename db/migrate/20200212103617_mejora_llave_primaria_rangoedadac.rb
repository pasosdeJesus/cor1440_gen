class MejoraLlavePrimariaRangoedadac < ActiveRecord::Migration[6.0]
  def up
    if Cor1440Gen::Rangoedadac.primary_key.nil?
      execute <<-SQL
        ALTER TABLE cor1440_gen_rangoedadac ADD PRIMARY KEY(id);
      SQL
    end
  end
  def down
  end
end
