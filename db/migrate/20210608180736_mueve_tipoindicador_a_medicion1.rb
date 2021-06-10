class MueveTipoindicadorAMedicion1 < ActiveRecord::Migration[6.1]
  def up
    add_column :cor1440_gen_mindicadorpf, :medircon, :integer

    add_column :cor1440_gen_datointermedioti, :mindicadorpf_id, :integer
    add_index :cor1440_gen_datointermedioti, :mindicadorpf_id
    add_foreign_key :cor1440_gen_datointermedioti, :cor1440_gen_mindicadorpf,
      column: :mindicadorpf_id

    create_join_table :mr519_gen_formulario, :cor1440_gen_mindicadorpf,
      table_name: :cor1440_gen_formulario_mindicadorpf
    add_foreign_key :cor1440_gen_formulario_mindicadorpf,
      :mr519_gen_formulario
    add_foreign_key :cor1440_gen_formulario_mindicadorpf,
      :cor1440_gen_mindicadorpf
    rename_column :cor1440_gen_formulario_mindicadorpf, 
      :mr519_gen_formulario_id, :formulario_id
    rename_column :cor1440_gen_formulario_mindicadorpf, 
      :cor1440_gen_mindicadorpf_id, :mindicadorpf_id

    execute <<-SQL
      UPDATE cor1440_gen_mindicadorpf
        SET medircon=t.medircon
        FROM cor1440_gen_indicadorpf AS i
        JOIN cor1440_gen_tipoindicador AS t ON i.tipoindicador_id=t.id
        WHERE indicadorpf_id=i.id
      ;
    SQL
    execute <<-SQL
      UPDATE cor1440_gen_datointermedioti
        SET mindicadorpf_id=m.id
        FROM cor1440_gen_mindicadorpf AS m
        JOIN cor1440_gen_indicadorpf AS i ON m.indicadorpf_id=i.id
        WHERE
        i.tipoindicador_id=cor1440_gen_datointermedioti.tipoindicador_id
      ;
    SQL
    execute <<-SQL
      INSERT INTO cor1440_gen_formulario_mindicadorpf 
        (formulario_id, mindicadorpf_id)
        (SELECT formulario_id, m.id 
          FROM cor1440_gen_formulario_tipoindicador AS ft
          JOIN cor1440_gen_indicadorpf AS i 
            ON ft.tipoindicador_id=i.tipoindicador_id
          JOIN cor1440_gen_mindicadorpf AS m
            ON m.indicadorpf_id = i.id
          WHERE (formulario_id, m.id) NOT IN
          (SELECT formulario_id, mindicadorpf_id FROM
            cor1440_gen_formulario_mindicadorpf)
        )
      ;
    SQL

    change_column :cor1440_gen_datointermedioti, :tipoindicador_id,
      :integer, null: true
  end

  def down
    change_column :cor1440_gen_datointermedioti, :tipoindicador_id,
      :integer, null: false
    drop_table :cor1440_gen_formulario_mindicadorpf
    remove_column :cor1440_gen_datointermedioti, :mindicadorpf_id
    remove_column :cor1440_gen_mindicadorpf, :medircon
  end
end
