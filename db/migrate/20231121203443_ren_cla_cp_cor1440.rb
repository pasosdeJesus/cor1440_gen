class RenClaCpCor1440 < ActiveRecord::Migration[7.0]

  include Msip::SqlHelper

  def up
    if existe_restricción_pg?("msip_clase_id_key")
      renombrar_restricción_pg(
        "msip_centropoblado",
        "msip_clase_id_key",
        "msip_centropoblado_id_uniq"
      )
    end
    if existe_restricción_pg?("msip_clase_id_municipio_fkey")
      renombrar_restricción_pg(
        "msip_centropoblado",
        "msip_clase_id_municipio_fkey",
        "msip_centropoblado_municipio_id_fkey"
      )
    end
    if existe_restricción_pg?("msip_persona_id_clase_fkey")
      renombrar_restricción_pg(
        "msip_persona",
        "msip_persona_id_clase_fkey",
        "msip_persona_centropoblado_id_fkey"
      )
    end
    if existe_restricción_pg?("msip_ubicacion_id_clase_fkey")
      renombrar_restricción_pg(
        "msip_ubicacion",
        "msip_ubicacion_id_clase_fkey",
        "msip_ubicacion_centropoblado_id_fkey"
      )
    end
  end

  def down
  end
end
