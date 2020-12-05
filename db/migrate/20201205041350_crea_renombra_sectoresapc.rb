class CreaRenombraSectoresapc < ActiveRecord::Migration[6.0]

  def up
    if ActiveRecord::Base.connection.table_exists? :sectorapc
      rename_table :sectorapc, :cor1440_gen_sectorapc
    else
      create_table :cor1440_gen_sectorapc do |t|
        t.string :nombre, limit: 500, null: false
        t.string :observaciones, limit: 5000
        t.date :fechacreacion, null: false
        t.date :fechadeshabilitacion
        t.timestamp :created_at, null: false
        t.timestamp :updated_at, null: false
      end
      add_column :cor1440_gen_proyectofinanciero, :sectorapc_id, :integer
      add_foreign_key :cor1440_gen_proyectofinanciero, :cor1440_gen_sectorapc,
        column: :sectorapc_id
      execute <<-SQL
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (1, 'SIN INFORMACIÓN', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (2, 'AGRICULTURA Y DESARROLLO RURAL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (3, 'AMBIENTE Y DESARROLLO SOSTENIBLE', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (4, 'CIENCIA, TECNOLOGÍA E INNOVACIÓN, COMERCIO, INDUSTRIA Y TURISMO', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (5, 'CORPORACIONES AUTÓNOMAS REGIONALES Y DE DESARROLLO SOSTENIBLE', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (6, 'CULTURA', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (7, 'DEFENSA NACIONAL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (8, 'DEPORTE', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (9, 'EDUCACIÓN NACIONAL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (10, 'ENTES UNIVERSITARIOS AUTÓNOMOS', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (11, 'ESTADÍSTICAS', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (12, 'FUNCIÓN PÚBLICA', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (13, 'HACIENDA Y CRÉDITO PÚBLICO', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (14, 'INCLUSIÓN SOCIAL Y RECONCILIACIÓN', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (15, 'INTELIGENCIA ESTRATÉGICA Y CONTRAINTELIGENCIA', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (16, 'INTERIOR', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (17, 'JUSTICIA Y DEL DERECHO', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (18, 'MINAS Y ENERGÍA', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (19, 'ORGANISMOS AUTÓNOMOS', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (20, 'ORGANISMOS DE CONTROL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (21, 'ORGANIZACIÓN ELECTORAL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (22, 'PLANEACIÓN', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (23, 'PRESIDENCIA DE LA REPÚBLICA', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (24, 'PROTECCIÓN SOCIAL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (25, 'RAMA JUDICIAL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (26, 'RAMA LEGISLATIVA', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (27, 'RELACIONES EXTERIORES', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (28, 'SALUD Y PROTECCIÓN SOCIAL', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (29, 'TRANSPORTE', '2018-04-20', '2018-04-20', '2018-04-20');
        INSERT INTO cor1440_gen_sectorapc (id, nombre, fechacreacion, created_at, updated_at) 
          VALUES (30, 'VIVIENDA CIUDAD Y TERRITORIO', '2018-04-20', '2018-04-20', '2018-04-20');
      SQL
    end
  end

  def down
    remove_column :cor1440_gen_proyectofinanciero, :sectorapc_id, :integer
    drop_table :cor1440_gen_sectorapc
  end
end
