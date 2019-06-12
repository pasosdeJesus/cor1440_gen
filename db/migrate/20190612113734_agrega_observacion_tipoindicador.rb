class AgregaObservacionTipoindicador < ActiveRecord::Migration[6.0]
  def up
    add_column :cor1440_gen_tipoindicador, :observaciones, :string, limit: 5000
    add_column :cor1440_gen_tipoindicador, :fechacreacion, :date,
      default: 'NOW()'
    add_column :cor1440_gen_tipoindicador, :fechadeshabilitacion, :date
    add_column :cor1440_gen_tipoindicador, :created_at, :date,
      default: 'NOW()'
    add_column :cor1440_gen_tipoindicador, :updated_at, :date,
      default: 'NOW()'
    execute <<-SQL
      UPDATE cor1440_gen_tipoindicador SET fechacreacion=NOW(),
        created_at=NOW(), updated_at=NOW();
    SQL
    change_column_null :cor1440_gen_tipoindicador, :fechacreacion, false
  end

  def down
    remove_column :cor1440_gen_tipoindicador, :observaciones
    remove_column :cor1440_gen_tipoindicador, :fechacreacion
    remove_column :cor1440_gen_tipoindicador, :fechadeshabilitacion
    remove_column :cor1440_gen_tipoindicador, :created_at
    remove_column :cor1440_gen_tipoindicador, :updated_at
  end
end
