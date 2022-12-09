class CambiosParaRenombrarMsip < ActiveRecord::Migration[7.0]
  include Msip::SqlHelper

  NOMIND= [
    ['anexoactividad_pkey', 'sip_anexo_pkey'],
    ['regionsjr_pkey', 'sip_oficina_pkey'],
  ]


  def up
    NOMIND.each do |nomini,nomfin|
      if existe_índice_pg?(nomini)
        renombrar_índice_pg(nomini, nomfin)
      end
    end
  end

  def down
  end
end
