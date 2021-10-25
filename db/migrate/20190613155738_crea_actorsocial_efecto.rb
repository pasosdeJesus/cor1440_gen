class CreaActorsocialEfecto < ActiveRecord::Migration[6.0]

  def up
    if !ActiveRecord::Base.connection.
      table_exists?(:cor1440_gen_actorsocial_efecto)
      create_table :cor1440_gen_actorsocial_efecto, id: false do |t|
        t.integer :efecto_id
        t.integer :actorsocial_id
      end
      add_foreign_key :cor1440_gen_actorsocial_efecto, :cor1440_gen_efecto,
        column: :efecto_id
      add_foreign_key :cor1440_gen_actorsocial_efecto, :sip_actorsocial,
        column: :actorsocial_id
    end
  end

end
