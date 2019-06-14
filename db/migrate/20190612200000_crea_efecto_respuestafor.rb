# encoding: UTF-8

class CreaEfectoRespuestafor < ActiveRecord::Migration[6.0]
  def up
    if !ActiveRecord::Base.connection.
      table_exists?(:cor1440_gen_efecto_respuestafor)
      create_table :cor1440_gen_efecto_respuestafor, id: false do |t|
        t.integer :efecto_id
        t.integer :respuestafor_id
      end
      add_foreign_key :cor1440_gen_efecto_respuestafor, :cor1440_gen_efecto,
        column: :efecto_id
      add_foreign_key :cor1440_gen_efecto_respuestafor, :mr519_gen_respuestafor,
        column: :respuestafor_id
  end
end
