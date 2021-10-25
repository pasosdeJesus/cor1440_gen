class CreaEfecto < ActiveRecord::Migration[6.0]
  def up
    if !ActiveRecord::Base.connection.table_exists?(:cor1440_gen_efecto)
      create_table :cor1440_gen_efecto do |t|
        t.integer :indicadorpf_id
        t.date :fecha
        t.integer :registradopor_id
        t.string :nombre, limit: 500
        t.string :descripcion, limit: 5000
      end
      add_foreign_key :cor1440_gen_efecto, :cor1440_gen_indicadorpf,
        column: :indicadorpf_id
      add_foreign_key :cor1440_gen_efecto, :usuario,
        column: :registradopor_id
    end
  end

  def down
  end
end
