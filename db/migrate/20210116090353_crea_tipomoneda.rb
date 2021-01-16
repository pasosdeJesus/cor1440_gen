class CreaTipomoneda < ActiveRecord::Migration[6.0]
  include Sip::MigracionHelper

  def up
    create_table :cor1440_gen_tipomoneda do |t|
      t.string :nombre, limit: 500, null: false
      t.string :codiso4217, limit: 3, null: false
      t.string :simbolo, limit: 10
      t.integer :pais_id
      t.string :observaciones, limit: 5000
      t.date :fechacreacion, null: false
      t.date :fechadeshabilitacion

      t.timestamps null: false
    end
    cambiaCotejacion('cor1440_gen_tipomoneda', 'nombre', 500, 'es_co_utf_8')
    add_foreign_key :cor1440_gen_tipomoneda, :sip_pais, column: :pais_id

    execute <<-SQL
      INSERT INTO cor1440_gen_tipomoneda (id, nombre, codiso4217, simbolo, pais_id, fechacreacion, created_at, updated_at) 
        VALUES (1, 'PESO', 'COP', '$', 170, '2016-02-18', '2016-02-18', '2016-02-18');
      INSERT INTO cor1440_gen_tipomoneda (id, nombre, codiso4217, simbolo, fechacreacion, created_at, updated_at) 
        VALUES (2, 'EURO', 'EUR', '€', '2016-02-18', '2016-02-18', '2016-02-18');
      INSERT INTO cor1440_gen_tipomoneda (id, nombre, codiso4217, simbolo, pais_id, fechacreacion, created_at, updated_at) 
        VALUES (3, 'DOLAR', 'USD', '$', 840, '2016-02-18', '2016-02-18', '2016-02-18');
      INSERT INTO cor1440_gen_tipomoneda (id, nombre, codiso4217, simbolo, pais_id, fechacreacion, created_at, updated_at) 
        VALUES (4, 'FRANCO SUIZO', 'CHF', 'CHF', 756, '2016-02-18', '2016-02-18', '2016-02-18');
      INSERT INTO cor1440_gen_tipomoneda (id, nombre, codiso4217, simbolo, pais_id, fechacreacion, created_at, updated_at) 
        VALUES (5, 'LIBRA INGLESA', 'GBP', '£', 826, '2016-02-18', '2016-02-18', '2016-02-18');
      INSERT INTO cor1440_gen_tipomoneda (id, nombre, codiso4217, simbolo, pais_id, fechacreacion, created_at, updated_at) 
        VALUES (6, 'CORONA SUECA', 'SEK', 'kr', 752, '2016-02-18', '2016-02-18', '2016-02-18');


      SELECT setval('cor1440_gen_tipomoneda_id_seq', 100);
    SQL
  end

  def down
    drop_table :cor1440_gen_tipomoneda
  end
end
