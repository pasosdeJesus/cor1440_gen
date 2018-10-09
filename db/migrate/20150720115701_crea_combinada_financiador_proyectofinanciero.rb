class CreaCombinadaFinanciadorProyectofinanciero < ActiveRecord::Migration[4.2]
  def change
    create_join_table :financiador, :proyectofinanciero, {
      table_name: 'cor1440_gen_financiador_proyectofinanciero' 
    }
    add_foreign_key :cor1440_gen_financiador_proyectofinanciero, 
      :cor1440_gen_financiador, column: :financiador_id
    add_foreign_key :cor1440_gen_financiador_proyectofinanciero, 
      :cor1440_gen_proyectofinanciero, column: :proyectofinanciero_id
  end
end
