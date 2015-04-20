class RenombraAnexo < ActiveRecord::Migration

  def up
    execute <<-SQL 
			ALTER SEQUENCE sivel2_gen_anexoactividad_id_seq 
        RENAME TO sip_anexo_id_seq
		SQL
	  execute <<-SQL
      ALTER TABLE sivel2_gen_anexoactividad
        RENAME TO sip_anexo;
    SQL

    create_join_table :cor1440_gen_actividad, :sip_anexo do |t|
      t.index :sip_anexo_id
    end

    rename_column :cor1440_gen_actividad_sip_anexo, :cor1440_gen_actividad_id,
      :actividad_id
    rename_column :cor1440_gen_actividad_sip_anexo, :sip_anexo_id,
      :anexo_id

    execute <<-SQL
      INSERT INTO cor1440_gen_actividad_sip_anexo
      (actividad_id, anexo_id) 
      (SELECT actividad_id, id FROM sip_anexo)
    SQL

    remove_column :sip_anexo, :actividad_id

    add_foreign_key :cor1440_gen_actividad_sip_anexo, :sip_anexo, 
      column: :anexo_id
    add_foreign_key :cor1440_gen_actividad_sip_anexo, :cor1440_gen_actividad,
      column: :actividad_id
  end

  def down

    remove_foreign_key :cor1440_gen_actividad_sip_anexo, :sip_anexo, 
      column: :anexo_id
    remove_foreign_key :cor1440_gen_actividad_sip_anexo, :cor1440_gen_actividad,
      column: :actividad_id
    add_column :sip_anexo, :actividad_id, :integer

    execute <<-SQL
      UPDATE sip_anexo
        SET actividad_id=cor1440_gen_actividad_sip_anexo.actividad_id
        FROM cor1440_gen_actividad_sip_anexo 
        WHERE anexo_id=sip_anexo.id 
      ;
    SQL

    drop_join_table :cor1440_gen_actividad, :sip_anexo

    execute <<-SQL 
			ALTER SEQUENCE sip_anexo_id_seq 
        RENAME TO sivel2_gen_anexoactividad_id_seq;
		SQL
	  execute <<-SQL
      ALTER TABLE sip_anexo 
        RENAME TO sivel2_gen_anexoactividad
    SQL

  end
end
