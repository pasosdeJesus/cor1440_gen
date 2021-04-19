class SexoPorOmisionContacto < ActiveRecord::Migration[6.1]
  def up
    execute <<-SQL
      ALTER TABLE sip_persona ALTER COLUMN sexo
        SET DEFAULT 'S';
    SQL
  end
  def down
    execute <<-SQL
      ALTER TABLE sip_persona ALTER COLUMN sexo
        DROP DEFAULT;
    SQL
  end
end
