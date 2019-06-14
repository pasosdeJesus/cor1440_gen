# encoding: UTF-8

class CreaAnexoEfecto < ActiveRecord::Migration[6.0]

  def up
    if !ActiveRecord::Base.connection.
      table_exists?(:cor1440_gen_anexo_efecto)
      create_table :cor1440_gen_anexo_efecto do |t|
        t.integer :efecto_id
        t.integer :anexo_id
      end
      add_foreign_key :cor1440_gen_anexo_efecto, :cor1440_gen_efecto,
        column: :efecto_id
      add_foreign_key :cor1440_gen_anexo_efecto, :sip_anexo,
        column: :anexo_id
    end
  end
end
