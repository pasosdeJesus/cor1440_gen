class RenombraActividad < ActiveRecord::Migration
  def up
    execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividad_id_seq 
        RENAME TO cor1440_gen_actividad_id_seq
    SQL
    execute <<-SQL
      ALTER TABLE sivel2_gen_actividad 
        RENAME TO cor1440_gen_actividad;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividad_rangoedadac_id_seq 
        RENAME TO cor1440_gen_actividad_rangoedadac_id_seq
    SQL
    execute <<-SQL
      ALTER TABLE sivel2_gen_actividad_rangoedadac 
        RENAME TO cor1440_gen_actividad_rangoedadac;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividadarea_id_seq 
        RENAME TO cor1440_gen_actividadarea_id_seq
    SQL
    execute <<-SQL
      ALTER TABLE sivel2_gen_actividadarea 
        RENAME TO cor1440_gen_actividadarea;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_actividadareas_actividad_id_seq 
        RENAME TO cor1440_gen_actividadareas_actividad_id_seq
    SQL
    execute <<-SQL
      ALTER TABLE sivel2_gen_actividadareas_actividad 
        RENAME TO cor1440_gen_actividadareas_actividad;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE sivel2_gen_rangoedadac_id_seq 
        RENAME TO cor1440_gen_rangoedadac_id_seq
    SQL
    execute <<-SQL
      ALTER TABLE sivel2_gen_rangoedadac 
        RENAME TO cor1440_gen_rangoedadac;
    SQL



  end

  def down
    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_rangoedadac_id_seq 
        RENAME TO sivel2_gen_rangoedadac_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_rangoedadac 
        RENAME TO sivel2_gen_rangoedadac;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividadareas_actividad_id_seq 
        RENAME TO sivel2_gen_actividadareas_actividad_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividadareas_actividad 
        RENAME TO sivel2_gen_actividadareas_actividad;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividadarea_id_seq 
        RENAME TO sivel2_gen_actividadarea_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividadarea 
        RENAME TO sivel2_gen_actividadarea;
    SQL

    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividad_rangoedadac_id_seq 
        RENAME TO sivel2_gen_actividad_rangoedadac_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad_rangoedadac 
        RENAME TO sivel2_gen_actividad_rangoedadac;
    SQL


    execute <<-SQL 
      ALTER SEQUENCE cor1440_gen_actividad_id_seq 
        RENAME TO sivel2_gen_actividad_id_seq;
    SQL
    execute <<-SQL
      ALTER TABLE cor1440_gen_actividad 
        RENAME TO sivel2_gen_actividad;
    SQL




  end
end
