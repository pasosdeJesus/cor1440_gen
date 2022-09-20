class CreaCombinadaFinanciadorProyectofinanciero < ActiveRecord::Migration[4.2]
  def up
    create_join_table :financiador, :proyectofinanciero
    rename_table :financiador_proyectofinanciero,
      'cor1440_gen_financiador_proyectofinanciero'
    add_foreign_key :cor1440_gen_financiador_proyectofinanciero, 
      :cor1440_gen_financiador, column: :financiador_id
    add_foreign_key :cor1440_gen_financiador_proyectofinanciero, 
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
  end
  def down
    drop_table 'cor1440_gen_financiador_proyectofinanciero'
  end
end
