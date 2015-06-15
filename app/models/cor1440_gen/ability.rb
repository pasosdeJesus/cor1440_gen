# encoding: UTF-8

module Cor1440Gen
  class Ability < Sip::Ability

    # Tablas básicas
    BASICAS = Sip::Ability::TABLAS_SIP + [
      ['Cor1440Gen', 'actividadarea'], 
      ['Cor1440Gen', 'actividadtipo'], 
      ['Cor1440Gen', 'financiador'], 
      ['Cor1440Gen', 'proyecto'], 
      ['Cor1440Gen', 'proyectofinanciero'], 
      ['Cor1440Gen', 'rangoedadac']
    ]  - [
      ['Sip', 'fuenteprensa'], 
      ['Sip', 'tdocumento'], 
      ['Sip', 'trelacion'], 
      ['Sip', 'tsitio']
    ]

    @@tablasbasicas = BASICAS

    # Tablas basicas cuya secuencia es de la forma tabla_id_seq 
    BASICAS_SID = Sip::Ability::TABLAS_SIP_SEQID + [ 
      ['Cor1440Gen', 'actividadarea'],
      ['Cor1440Gen', 'actividadtipo'],
      ['Cor1440Gen', 'financiador'], 
      ['Cor1440Gen', 'proyecto'], 
      ['Cor1440Gen', 'proyectofinanciero'], 
      ['Cor1440Gen', 'rangoedadac']
    ]

    @@basicas_seq_con_id = BASICAS_SID

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
      #["Analista de Actividades", ROLANALI], 
      ["Sistematizador de Actividades", ROLSISTACT]
    ]


    # Ver documentacion de este metodo en app/models/ability de sip
    def initialize(usuario)
      # Sin autenticación puede consultarse información geográfica 
      can :read, [Sip::Pais, Sip::Departamento, Sip::Municipio, Sip::Clase]
      if !usuario || usuario.fechadeshabilitacion
        return
      end
      can :contar, Sip::Ubicacion
      can :buscar, Sip::Ubicacion
      can :lista, Sip::Ubicacion
      can :descarga_anexo, Sip::Anexo
      can :nuevo, Cor1440Gen::Actividad
      can :nuevo, Sip::Ubicacion
      if !usuario.nil? && !usuario.rol.nil? then
        case usuario.rol 
        when Ability::ROLSISTACT
          can :read, Cor1440Gen::Actividad
          can :new, Cor1440Gen::Actividad
          can [:update, :create, :destroy], Cor1440Gen::Actividad, 
            oficina: { id: usuario.oficina_id}
        when Ability::ROLCOOR
          can :read, Cor1440Gen::Actividad
          can :new, Cor1440Gen::Actividad
          can [:update, :create, :destroy], Cor1440Gen::Actividad, 
            oficina: { id: usuario.oficina_id}
          can :new, Usuario
          can [:read, :manage], Usuario, oficina: { id: usuario.oficina_id}
        when Ability::ROLDIR
          can [:read, :new, :update, :create, :destroy], Cor1440Gen::Actividad
          can :manage, Usuario
          can :manage, :tablasbasicas
          @@tablasbasicas.each do |t|
            c = Ability.tb_clase(t)
            can :manage, c
          end
        when Ability::ROLINV
          cannot :buscar, Sip::Actividad
          can :read, Sip::Actividad
        when Ability::ROLADMIN
          can :manage, Cor1440Gen::Actividad
          can :manage, Usuario
          can :manage, :tablasbasicas
          @@tablasbasicas.each do |t|
            c = Ability.tb_clase(t)
            can :manage, c
          end
        end
      end
    end
  end
end
