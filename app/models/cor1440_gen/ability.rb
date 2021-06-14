# encoding: UTF-8

module Cor1440Gen
  class Ability < Sip::Ability

    ROLADMIN  = 1
    ROLDIR    = 3
    ROLOPERADOR = 5 # Analista
    #ROLSISACT = 7

    ROLES = [
      ["Administrador", ROLADMIN],
      ["", 0],
      ["Directivo", ROLDIR],
      ["", 0],
      ["Operador", ROLOPERADOR],
      ["", 0 ],
      ["", 0],
      ["", 0]
    ]

    # Tablas básicas
    BASICAS_PROPIAS= [
      ['Cor1440Gen', 'actividadarea'],
#      ['Cor1440Gen', 'actividadtipo'],
      ['Cor1440Gen', 'financiador'],
      ['Cor1440Gen', 'proyecto'],
      ['Cor1440Gen', 'rangoedadac'],
      ['Cor1440Gen', 'sectorapc'],
      ['Cor1440Gen', 'tipoindicador'],
      ['Cor1440Gen', 'tipomoneda']
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

    NOBASICAS_INDSEQID =  [
      ['cor1440_gen', 'actividadpf'],
      ['cor1440_gen', 'indicadorpf'],
      ['cor1440_gen', 'objetivopf'],
      ['cor1440_gen', 'proyectofinanciero_usuario'],
      ['cor1440_gen', 'resultadopf']
    ]
    # Hereda nobasicas_indice_seq_con_id de sip
    def nobasicas_indice_seq_con_id
      Sip::Ability::NOBASICAS_INDSEQID +
        Cor1440Gen::Ability::NOBASICAS_INDSEQID
    end

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
          'anexos_ids',
          'asistentes_nombres',
          'asistentes_ids',
          'campos_dinamicos',
          'corresponsables',
          'creacion',
          'fecha',
          'fecha_localizada',
          'id',
          'lugar',
          'nombre',
          'numero_anexos',
          'objetivo',
          'observaciones',
          Cor1440Gen::Actividad.human_attribute_name(
            :objetivopf).downcase.gsub(' ', '_'),
          'oficina',
          'organizaciones_sociales',
          'organizaciones_sociales_ids',
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
            :proyectofinanciero).downcase.gsub(' ', '_') + '_id',
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectos).downcase.gsub(' ', '_'),
          'responsable',
          'responsable_nombre',
          'resultado',
        ],
        controlador: 'Cor1440Gen::ActividadesController',
        ruta: '/actividades'
      },
      'Proyecto' => {
        campos: [
          'compromisos',
          'equipotrabajo',
          'fechainicio_localizada',
          'fechacierre_localizada',
          'fechacreacion_localizada',
          'fechaactualizacion_localizada',
          'financiador',
          'id',
          'monto',
          'nombre',
          'observaciones',
          'responsable',
        ],
        controlador: 'Cor1440Gen::Proyectofinanciero',
        ruta: '/proyectosfinancieros'
      },
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

      can [:nuevo, :new], Cor1440Gen::Actividad
      can :read, Cor1440Gen::Rangoedadac

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
        when ROLOPERADOR

          presponsable = Cor1440Gen::Proyectofinanciero.where(
            responsable_id: usuario.id).map(&:id)
          can [:read,:edit,:update], Cor1440Gen::Proyectofinanciero,
            responsable: { id: usuario.id}

          # Convención: Los proyectos sin usuarios se suponen como
          # institucionales o para todos los usuarios
          psinusuario = Cor1440Gen::Proyectofinanciero.all.map(&:id) -
            Cor1440Gen::ProyectofinancieroUsuario.all.map(
              &:proyectofinanciero_id).uniq
          can :read, Cor1440Gen::Proyectofinanciero,
            id: psinusuario
          # Puede ver proyectos en cuyo equipo de trabajo este
          penequipo1 = Cor1440Gen::ProyectofinancieroUsuario.where(
            usuario_id: usuario.id).map(&:proyectofinanciero_id).uniq
          penequipo = penequipo1 | presponsable
          penequipo.uniq!
          # Según
          # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/Defining-Abilities:-Best-Practices.md
          # Al poner varios corresponde al OR
          # Poner varios hashes en una línea es un AND
          can :read, Cor1440Gen::Proyectofinanciero,
            id: penequipo

          can :manage, Cor1440Gen::Actividad,
            responsable: { id: usuario.id}
          can :read, Cor1440Gen::Actividad,
            actividad_proyectofinanciero: {proyectofinanciero_id: penequipo}

          # Responsable de un proyecto puede eliminar  y editar actividades
          # del mismo
          can :manage, Cor1440Gen::Actividad,
            actividad_proyectofinanciero: {proyectofinanciero_id: presponsable}

          can :read, Cor1440Gen::Efecto
          can :read, Cor1440Gen::FormularioTipoindicador
          can :read, Cor1440Gen::Informe

          can [:new, :create, :read, :index, :edit, :update],
            Sip::Orgsocial
          can :manage, Sip::Persona

        when Ability::ROLADMIN, Ability::ROLDIR
          can :manage, Cor1440Gen::Actividad
          can :manage, Cor1440Gen::Campotind
          can :manage, Cor1440Gen::Efecto
          can :manage, Cor1440Gen::Financiador
          can :manage, Cor1440Gen::FormularioTipoindicador
          can :manage, Cor1440Gen::Indicadorpf
          can :manage, Cor1440Gen::Informe
          can :manage, Cor1440Gen::Mindicadorpf
          can :manage, Cor1440Gen::Proyectofinanciero
          can :manage, Cor1440Gen::Tipoindicador

          can :manage, Heb412Gen::Doc
          can :manage, Heb412Gen::Plantilladoc
          can :manage, Heb412Gen::Plantillahcm
          can :manage, Heb412Gen::Plantillahcr

          can :manage, Mr519Gen::Formulario

          can :manage, Sip::Orgsocial
          can :manage, Sip::Sectororgsocial
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
