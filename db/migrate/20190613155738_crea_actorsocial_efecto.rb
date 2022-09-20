class CreaActorsocialEfecto < ActiveRecord::Migration[6.0]

  def up
    if !table_exists?(:cor1440_gen_actorsocial_efecto) && table_exists?(:sip_actorsocial)
      create_table :cor1440_gen_actorsocial_efecto, id: false do |t|
        t.integer :efecto_id
        t.integer :actorsocial_id
      end
      add_foreign_key :cor1440_gen_actorsocial_efecto, :cor1440_gen_efecto,
        column: :efecto_id
      add_foreign_key :cor1440_gen_actorsocial_efecto, :sip_actorsocial,
        column: :actorsocial_id
    elsif !table_exists?(:cor1440_gen_efecto_orgsocial) && table_exists?(:sip_orgsocial)
      create_table :cor1440_gen_efecto_orgsocial, id: false do |t|
        t.integer :efecto_id
        t.integer :orgsocial_id
      end
      add_foreign_key :cor1440_gen_efecto_orgsocial, :cor1440_gen_efecto,
        column: :efecto_id
      add_foreign_key :cor1440_gen_efecto_orgsocial, :sip_orgsocial,
        column: :orgsocial_id
    end
  end

end
