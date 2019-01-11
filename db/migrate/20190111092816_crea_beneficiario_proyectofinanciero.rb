class CreaBeneficiarioProyectofinanciero < ActiveRecord::Migration[5.2]
  def change
    create_table :cor1440_gen_beneficiariopf, id: false do |t|
      t.integer :persona_id
      t.integer :proyectofinanciero_id
    end
    add_foreign_key :cor1440_gen_beneficiariopf, 
      :cor1440_gen_proyectofinanciero, 
      column: :proyectofinanciero_id
    add_foreign_key :cor1440_gen_beneficiariopf, :sip_persona, 
      column: :persona_id
  end
end
