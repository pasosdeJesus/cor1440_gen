class AgRestBorradoVictimasjr < ActiveRecord::Migration
  def change
    execute <<-SQL
    ALTER TABLE cor1440_gen_victimasjr
    DROP CONSTRAINT victimasjr_id_victima_fkey,
    ADD CONSTRAINT victimasjr_id_victima_fkey
       FOREIGN KEY (id_victima)
       REFERENCES sip_victima(id)
       ON DELETE CASCADE;
    SQL
  end
end
