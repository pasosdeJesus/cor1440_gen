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
        ['Sip', 'grupo'], 
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
          Cor1440Gen::Actividad.human_attribute_name(
            :actividadareas).downcase.gsub(' ', '_'), 
          Cor1440Gen::Actividad.human_attribute_name(
            :actividadpf).downcase.gsub(' ', '_'), 
          'actualizacion',
          'anexo_1_desc',
          'anexo_2_desc',
          'anexo_3_desc',
          'anexo_4_desc',
          'anexo_5_desc',
          'campos_dinamicos', 
          'corresponsables', 
          'creacion', 
          'fecha', 
          'fecha_localizada', 
          'id', 
          'lugar', 
          'nombre', 
          'objetivo', 
          'observaciones', 
          'objetivo_convenio_financiero',
          'oficina', 
          'poblacion', 
          'poblacion_mujeres_l',
          'poblacion_mujeres_r',
          'poblacion_hombres_l',
          'poblacion_hombres_r',
          'poblacion_mujeres_l_g1',
          'poblacion_mujeres_r_g1',
          'poblacion_hombres_l_g1',
          'poblacion_hombres_r_g1',
          'poblacion_mujeres_l_g2',
          'poblacion_mujeres_r_g2',
          'poblacion_hombres_l_g2',
          'poblacion_hombres_r_g2',
          'poblacion_mujeres_l_g3',
          'poblacion_mujeres_r_g3',
          'poblacion_hombres_l_g3',
          'poblacion_hombres_r_g3',
          'poblacion_mujeres_l_g4',
          'poblacion_mujeres_r_g4',
          'poblacion_hombres_l_g4',
          'poblacion_hombres_r_g4',
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectofinanciero).downcase.gsub(' ', '_'), 
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectos).downcase.gsub(' ', '_'), 
          'responsable', 
          'resultado', 
        ],
        controlador: 'Cor1440Gen::ActividadesController',
        ruta: '/actividades'
      }
    }

    def campos_plantillas 
      Heb412Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS.
        clone.merge(CAMPOS_PLANTILLAS_PROPIAS)
    end

  end # class
end   # module
