# encoding: UTF-8

module Cor1440Gen
  class Ability < Sip::Ability

    ROLADMIN  = 1
    ROLINV    = 2
    ROLDIR    = 3
    ROLCOOR   = 4
    #ROLANALI  = 5
    #ROLSIST
    ROLSISTACT   = 7

    ROLES = [
      ["Administrador", ROLADMIN], 
      ["Invitado", ROLINV], 
      ["Directivo", ROLDIR], 
      ["Coordinador Proyecto", ROLCOOR], 
      ["", 0 ],
      ["", 0],
      ["Sistematizador de Actividades", ROLSISTACT]
    ]

    # Tablas básicas
    BASICAS_PROPIAS= [
      ['Cor1440Gen', 'actividadarea'], 
      ['Cor1440Gen', 'actividadtipo'], 
      ['Cor1440Gen', 'financiador'], 
      ['Cor1440Gen', 'proyecto'], 
      ['Cor1440Gen', 'rangoedadac']
    ]  
    def tablasbasicas 
      Sip::Ability::BASICAS_PROPIAS + BASICAS_PROPIAS - [
        ['Sip', 'fuenteprensa'], 
        ['Sip', 'tdocumento'], 
        ['Sip', 'trelacion'], 
        ['Sip', 'tsitio']
      ]
    end

    BASICAS_ID_NOAUTO = []
    # Hereda basicas_id_noauto de sip
   
    NOBASICAS_INDSEQID =  []
    # Hereda nobasicas_indice_seq_con_id de sip
   
    BASICAS_PRIO = []
    # Hereda tablasbasicas_prio de sip

    CAMPOS_PLANTILLAS_PROPIAS = {
      'Actividad' => { 
        campos: [
          'id', 'nombre', 'fecha', 'lugar', 'oficina', 
          'tipos_de_actividad', 'convenios_financieros', 'areas', 'subareas', 
          'responsable', 'corresponsables', 'objetivo', 
          'resultado', 'poblacion', 'observaciones', 
          'creacion', 'actualizacion'
        ],
        controlador: 'Cor1440Gen::ActividadesController'
      }
    }

    def campos_plantillas 
      Heb412Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.
        clone.merge(CAMPOS_PLANTILLAS_PROPIAS)
    end

  end # class
end   # module
