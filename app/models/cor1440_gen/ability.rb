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
      ['Cor1440Gen', 'rangoedadac'],
      ['Cor1440Gen', 'tipoindicador']
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
          'poblacion_sinsexo',
          'poblacion_mujeres_l_g1',
          'poblacion_mujeres_r_g1',
          'poblacion_hombres_l_g1',
          'poblacion_hombres_r_g1',
          'poblacion_sinsexo_g1',
          'poblacion_mujeres_l_g2',
          'poblacion_mujeres_r_g2',
          'poblacion_hombres_l_g2',
          'poblacion_hombres_r_g2',
          'poblacion_sinsexo_g2',
          'poblacion_mujeres_l_g3',
          'poblacion_mujeres_r_g3',
          'poblacion_hombres_l_g3',
          'poblacion_hombres_r_g3',
          'poblacion_sinsexo_g3',
          'poblacion_mujeres_l_g4',
          'poblacion_mujeres_r_g4',
          'poblacion_hombres_l_g4',
          'poblacion_hombres_r_g4',
          'poblacion_sinsexo_g4',
          'poblacion_mujeres_l_g5',
          'poblacion_mujeres_r_g5',
          'poblacion_hombres_l_g5',
          'poblacion_hombres_r_g5',
          'poblacion_sinsexo_g5',
          'poblacion_mujeres_l_g6',
          'poblacion_mujeres_r_g6',
          'poblacion_hombres_l_g6',
          'poblacion_hombres_r_g6',
          'poblacion_sinsexo_g6',
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

    def initialize_cor1440_gen(usuario = nil)
      # Sin autenticación puede consultarse información geográfica 
      can :read, [Sip::Pais, Sip::Departamento, Sip::Municipio, Sip::Clase]
      if !usuario || usuario.fechadeshabilitacion
        return
      end
      can :nuevo, Cor1440Gen::Actividad
  
      can :read, Heb412Gen::Doc
      can :read, Heb412Gen::Plantilladoc
      can :read, Heb412Gen::Plantillahcm
      can :read, Heb412Gen::Plantillahcr
  
      can :descarga_anexo, Sip::Anexo
      can :contar, Sip::Ubicacion
      can :buscar, Sip::Ubicacion
      can :lista, Sip::Ubicacion
      can :nuevo, Sip::Ubicacion
  
      if !usuario.nil? && !usuario.rol.nil? then
        case usuario.rol 
        when Ability::ROLSISTACT
  
          can :read, Cor1440Gen::Actividad
          can :new, Cor1440Gen::Actividad
          can [:update, :create, :destroy], Cor1440Gen::Actividad, 
            oficina: { id: usuario.oficina_id}
          can :read, Cor1440Gen::FormularioTipoindicador
          can :read, Cor1440Gen::Informe
          can :read, Cor1440Gen::Proyectofinanciero
  
          can [:new, :create, :read, :index, :edit, :update],
            Sip::Actorsocial
          can :manage, Sip::Persona
  
        when Ability::ROLCOOR
          can :new, Usuario
          can [:read, :manage], Usuario, oficina: { id: usuario.oficina_id}
  
          can :manage, Cor1440Gen::Actividad
          can [:update, :create, :destroy], Cor1440Gen::Actividad, 
            oficina: { id: usuario.oficina_id}
          can :read, Cor1440Gen::FormularioTipoindicador
          can :manage, Cor1440Gen::Informe
          can :read, Cor1440Gen::Proyectofinanciero
  
          can [:new, :create, :read, :index, :edit, :update],
            Sip::Actorsocial
          can :manage, Sip::Persona
        when Ability::ROLINV
          cannot :buscar, Sip::Actividad
          can :read, Sip::Actividad
        when Ability::ROLADMIN, Ability::ROLDIR
          can :manage, Cor1440Gen::Actividad
          can :manage, Cor1440Gen::Campotind
          can :manage, Cor1440Gen::Financiador
          can :manage, Cor1440Gen::FormularioTipoindicador
          can :manage, Cor1440Gen::Indicadorpf
          can :manage, Cor1440Gen::Informe
          can :manage, Cor1440Gen::Mindicadorpf
          can :manage, Cor1440Gen::Proyectofinanciero
          can :manage, Cor1440Gen::Sectoractor
          can :manage, Cor1440Gen::Tipoindicador
  
          can :manage, Heb412Gen::Doc
          can :manage, Heb412Gen::Plantilladoc
          can :manage, Heb412Gen::Plantillahcm
          can :manage, Heb412Gen::Plantillahcr
          
          can :manage, Mr519Gen::Formulario
  
          can :manage, Sip::Actorsocial
          can :manage, Sip::Persona
  
          can :manage, Usuario
          can :manage, :tablasbasicas
          tablasbasicas.each do |t|
            c = Ability.tb_clase(t)
            can :manage, c
          end
        end
      end
    end # initialize_cor1440_gen

  end # class
end   # module
