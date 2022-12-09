class MejoraEstructura < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper

  NOMIND= [
    ["index_cor1440_gen_actividad_sip_anexo_on_sip_anexo_id", 
     "index_cor1440_gen_actividad_anexo_on_anexo_id"],
  ]

  NOMRES = [
    ["cor1440_gen_actividad_anexo",
     "cor1440_gen_actividad_sip_anexo_id_key",
     "cor1440_gen_actividad_anexo_id_key"],
    ["usuario",
     "usuario_sip_oficina_id_fk",
     "usuario_oficina_id_fk" ],
  ]

  TABLASPE = [
    "actividad_poa",
    "poa",
    "divipola_oficial_2021_corregido"
  ]

  def up
    execute <<~SQL.squish
      DROP VIEW IF EXISTS msip_divipola;
    SQL

    TABLASPE.each do |t|
      if table_exists?(t)
        drop_table(t)
      end
    end

    rename_table("cor1440_gen_actividad_sip_anexo", 
                 "cor1440_gen_actividad_anexo")

    NOMIND.each do |nomini,nomfin|
      if existe_índice_pg?(nomini)
        renombrar_índice_pg(nomini, nomfin)
      end
    end

    NOMRES.each do |tabla, nomini, nomfin|
      if existe_restricción_pg?(nomini)
        renombrar_restricción_pg(tabla, nomini, nomfin)
      end
    end
  end

  def down
    NOMRES.reverse.each do |tabla, nomini, nomfin|
      if existe_restricción_pg?(nomfin)
        renombrar_restricción_pg(tabla, nomfin, nomini)
      end
    end

    NOMIND.reverse.each do |nomini,nomfin|
      if existe_índice_pg?(nomfin)
        renombrar_índice_pg(nomfin, nomini)
      end
    end
    rename_table("cor1440_gen_actividad_anexo",
                 "cor1440_gen_actividad_sip_anexo")
  end
end
