# frozen_string_literal: true

module Cor1440Gen
  # Permisos
  class Ability < Msip::Ability
    ROLADMIN  = 1
    ROLDIR    = 3
    ROLOPERADOR = 5 # Analista
    # ROLSISACT = 7

    ROLES = [
      ["Administrador", ROLADMIN],
      ["", 0],
      ["Directivo", ROLDIR],
      ["", 0],
      ["Operador", ROLOPERADOR],
      ["", 0],
      ["", 0],
      ["", 0],
    ]

    # Tablas básicas
    BASICAS_PROPIAS = [
      ["Cor1440Gen", "actividadarea"],
      #      ['Cor1440Gen', 'actividadtipo'],
      ["Cor1440Gen", "financiador"],
      ["Cor1440Gen", "proyecto"],
      ["Cor1440Gen", "rangoedadac"],
      ["Cor1440Gen", "sectorapc"],
      ["Cor1440Gen", "tipoindicador"],
      ["Cor1440Gen", "tipomoneda"],
    ]
    def tablasbasicas
      Msip::Ability::BASICAS_PROPIAS + BASICAS_PROPIAS - [
        ["Msip", "fuenteprensa"],
        ["Msip", "grupo"],
      ]
    end

    BASICAS_ID_NOAUTO = []
    # Hereda basicas_id_noauto de msip

    NOBASICAS_INDSEQID = [
      ["cor1440_gen", "actividad"],
      ["cor1440_gen", "actividad_anexo"],
      ["cor1440_gen", "actividadpf"],
      ["cor1440_gen", "asistencia"],
      ["cor1440_gen", "anexo_efecto"],
      ["cor1440_gen", "anexo_proyectofinanciero"],
      ["cor1440_gen", "caracterizacionpersona"],
      ["cor1440_gen", "datointermedioti"],
      ["cor1440_gen", "datointermedioti_pmindicadorpf"],
      ["cor1440_gen", "desembolso"],
      ["cor1440_gen", "efecto"],
      ["cor1440_gen", "indicadorpf"],
      ["cor1440_gen", "informe"],
      ["cor1440_gen", "informeauditoria"],
      ["cor1440_gen", "informefinanciero"],
      ["cor1440_gen", "informenarrativo"],
      ["cor1440_gen", "mindicadorpf"],
      ["cor1440_gen", "objetivopf"],
      ["cor1440_gen", "pmindicadorpf"],
      ["cor1440_gen", "proyectofinanciero"],
      ["cor1440_gen", "proyectofinanciero_usuario"],
      ["cor1440_gen", "rangoedadac"],
      ["cor1440_gen", "resultadopf"],
    ]
    # Hereda nobasicas_indice_seq_con_id de msip
    def nobasicas_indice_seq_con_id
      Msip::Ability::NOBASICAS_INDSEQID +
        Mr519Gen::Ability::NOBASICAS_INDSEQID +
        Heb412Gen::Ability::NOBASICAS_INDSEQID +
        Cor1440Gen::Ability::NOBASICAS_INDSEQID
    end

    BASICAS_PRIO = []
    # Hereda tablasbasicas_prio de msip

    CAMPOS_PLANTILLAS_PROPIAS = {
      "Actividad" => {
        campos: [
          Cor1440Gen::Actividad.human_attribute_name(
            :actividadareas,
          ).downcase.gsub(" ", "_"),
          Cor1440Gen::Actividad.human_attribute_name(
            :actividadpf,
          ).downcase.gsub(" ", "_"),
          "actualizacion",
          "anexo_1_desc",
          "anexo_2_desc",
          "anexo_3_desc",
          "anexo_4_desc",
          "anexo_5_desc",
          "anexos_ids",
          "asistentes_nombres",
          "asistentes_ids",
          "campos_dinamicos",
          "corresponsables",
          "creacion",
          "fecha",
          "fecha_localizada",
          "id",
          "lugar",
          "nombre",
          "numero_anexos",
          "objetivo",
          "observaciones",
          Cor1440Gen::Actividad.human_attribute_name(
            :objetivopf,
          ).downcase.gsub(" ", "_"),
          "oficina",
          "organizaciones_sociales",
          "organizaciones_sociales_ids",
          "poblacion",
          "poblacion_mujeres_l",
          "poblacion_mujeres_r",
          "poblacion_hombres_l",
          "poblacion_hombres_r",
          "poblacion_sinsexo",
          "poblacion_mujeres_l_g1",
          "poblacion_mujeres_r_g1",
          "poblacion_hombres_l_g1",
          "poblacion_hombres_r_g1",
          "poblacion_sinsexo_g1",
          "poblacion_mujeres_l_g2",
          "poblacion_mujeres_r_g2",
          "poblacion_hombres_l_g2",
          "poblacion_hombres_r_g2",
          "poblacion_sinsexo_g2",
          "poblacion_mujeres_l_g3",
          "poblacion_mujeres_r_g3",
          "poblacion_hombres_l_g3",
          "poblacion_hombres_r_g3",
          "poblacion_sinsexo_g3",
          "poblacion_mujeres_l_g4",
          "poblacion_mujeres_r_g4",
          "poblacion_hombres_l_g4",
          "poblacion_hombres_r_g4",
          "poblacion_sinsexo_g4",
          "poblacion_mujeres_l_g5",
          "poblacion_mujeres_r_g5",
          "poblacion_hombres_l_g5",
          "poblacion_hombres_r_g5",
          "poblacion_sinsexo_g5",
          "poblacion_mujeres_l_g6",
          "poblacion_mujeres_r_g6",
          "poblacion_hombres_l_g6",
          "poblacion_hombres_r_g6",
          "poblacion_sinsexo_g6",
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectofinanciero,
          ).downcase.gsub(" ", "_"),
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectofinanciero,
          ).downcase.gsub(" ", "_") + "_id",
          Cor1440Gen::Actividad.human_attribute_name(
            :proyectos,
          ).downcase.gsub(" ", "_"),
          "responsable",
          "responsable_nombre",
          "resultado",
        ],
        controlador: "Cor1440Gen::ActividadesController",
        ruta: "/actividades",
      },
      "Proyecto" => {
        campos: [
          "compromisos",
          "equipotrabajo",
          "fechainicio_localizada",
          "fechacierre_localizada",
          "fechacreacion_localizada",
          "fechaactualizacion_localizada",
          "financiador",
          "id",
          "monto",
          "nombre",
          "observaciones",
          "responsable",
        ],
        controlador: "Cor1440Gen::Proyectofinanciero",
        ruta: "/proyectosfinancieros",
      },
    }

    def campos_plantillas
      Heb412Gen::Ability::CAMPOS_PLANTILLAS_PROPIAS
        .clone.merge(CAMPOS_PLANTILLAS_PROPIAS)
    end

    # Se definen habilidades con cancancan
    # Util en motores y aplicaciones de prueba
    # En aplicaciones es mejor escribir completo el modelo de autorización
    # para facilitar su análisis y evitar cambios inesperados al actualizar
    # motores
    # @usuario Usuario que hace petición
    def self.initialize_cor1440_gen(habilidad, usuario = nil)
      # Sin autenticación puede consultarse información geográfica
      habilidad.can(:read, [Msip::Pais, Msip::Departamento, Msip::Municipio, Msip::Centropoblado])
      if !usuario || usuario.fechadeshabilitacion
        return
      end

      habilidad.can([:nuevo, :new], Cor1440Gen::Actividad)
      habilidad.can(:manage, Cor1440Gen::ActividadProyectofinanciero)
      habilidad.can([:nuevo, :new], Cor1440Gen::Actividadpf)
      habilidad.can(:read, Cor1440Gen::Rangoedadac)

      habilidad.can(:read, Heb412Gen::Doc)
      habilidad.can(:read, Heb412Gen::Plantilladoc)
      habilidad.can(:read, Heb412Gen::Plantillahcm)
      habilidad.can(:read, Heb412Gen::Plantillahcr)

      habilidad.can(:descarga_anexo, Msip::Anexo)
      habilidad.can(:contar, Msip::Ubicacion)
      habilidad.can(:buscar, Msip::Ubicacion)
      habilidad.can(:lista, Msip::Ubicacion)
      habilidad.can(:nuevo, Msip::Ubicacion)

      if !usuario.nil? && !usuario.rol.nil?
        case usuario.rol
        when ROLOPERADOR

          habilidad.can(:manage, [
            Cor1440Gen::Actividadpf,
            Cor1440Gen::ActividadProyectofinanciero,
            Cor1440Gen::AnexoProyectofinanciero,
            Cor1440Gen::Asistencia,
            Cor1440Gen::Desembolso,
            Cor1440Gen::DesembolsoProyectofinanciero,
            Cor1440Gen::ProyectofinancieroUsuario
          ])
          presponsable = Cor1440Gen::Proyectofinanciero.where(
            responsable_id: usuario.id,
          ).map(&:id)
          habilidad.can(
            [:read, :edit, :update],
            Cor1440Gen::Proyectofinanciero,
            responsable: { id: usuario.id },
          )

          # Convención: Los proyectos sin usuarios se suponen como
          # institucionales o para todos los usuarios
          psinusuario = Cor1440Gen::Proyectofinanciero.all.map(&:id) -
            Cor1440Gen::ProyectofinancieroUsuario.all.map(
              &:proyectofinanciero_id
            ).uniq
          habilidad.can(
            :read,
            Cor1440Gen::Proyectofinanciero,
            id: psinusuario,
          )
          # Puede ver proyectos en cuyo equipo de trabajo este
          penequipo1 = Cor1440Gen::ProyectofinancieroUsuario.where(
            usuario_id: usuario.id,
          ).map(&:proyectofinanciero_id).uniq
          penequipo = penequipo1 | presponsable
          penequipo.uniq!
          # Según
          # https://github.com/CanCanCommunity/cancancan/blob/develop/docs/Defining-Abilities:-Best-Practices.md
          # Al poner varios corresponde al OR
          # Poner varios hashes en una línea es un AND
          habilidad.can(
            :read,
            Cor1440Gen::Proyectofinanciero,
            id: penequipo,
          )

          habilidad.can(:read, [
            Msip::Anexo,
            Cor1440Gen::AnexoProyectofinanciero,
            Cor1440Gen::Desembolso,
            Cor1440Gen::Informeauditoria,
            Cor1440Gen::Informefinanciero,
            Cor1440Gen::Informenarrativo,
            Cor1440Gen::ProyectofinancieroUsuario,
          ])
          habilidad.can(
            :manage,
            Cor1440Gen::Actividad,
            responsable: { id: usuario.id },
          )
          habilidad.can(
            :read,
            Cor1440Gen::Actividad,
            actividad_proyectofinanciero: { proyectofinanciero_id: penequipo },
          )
          habilidad.can :manage, [
            Cor1440Gen::ActividadProyectofinanciero,
            Cor1440Gen::Asistencia,
          ]

          # Responsable de un proyecto puede eliminar  y editar actividades
          # del mismo
          habilidad.can(
            :manage,
            Cor1440Gen::Actividad,
            actividad_proyectofinanciero: { proyectofinanciero_id: presponsable },
          )
          habilidad.can(:manage, Cor1440Gen::ActividadProyectofinanciero)

          habilidad.can(:read, Cor1440Gen::Efecto)
          habilidad.can(:read, Cor1440Gen::FormularioTipoindicador)
          habilidad.can(:read, Cor1440Gen::Informe)

          habilidad.can(
            [:new, :create, :read, :index, :edit, :update],
            Msip::Orgsocial,
          )
          habilidad.can(:manage, Msip::Persona)

        when Ability::ROLADMIN, Ability::ROLDIR
          habilidad.can(:manage, [
            Cor1440Gen::Pmindicadorpf, 
            Cor1440Gen::Actividad,
            Cor1440Gen::ActividadProyectofinanciero,
            Cor1440Gen::AnexoProyectofinanciero,
            Cor1440Gen::Asistencia,
            Cor1440Gen::Actividadpf,
            Cor1440Gen::Desembolso,
            Cor1440Gen::Efecto,
            Cor1440Gen::Financiador,
            Cor1440Gen::FormularioTipoindicador,
            Cor1440Gen::Indicadorpf,
            Cor1440Gen::Informe,
            Cor1440Gen::Informeauditoria,
            Cor1440Gen::Informefinanciero,
            Cor1440Gen::Informenarrativo,
            Cor1440Gen::Mindicadorpf,
            Cor1440Gen::Objetivopf,
            Cor1440Gen::Proyectofinanciero,
            Cor1440Gen::ProyectofinancieroUsuario,
            Cor1440Gen::Resultadopf,
            Cor1440Gen::Tipoindicador,

            Heb412Gen::Doc,
            Heb412Gen::Plantilladoc,
            Heb412Gen::Plantillahcm,
            Heb412Gen::Plantillahcr,

            Mr519Gen::Campo,
            Mr519Gen::Formulario,
            Mr519Gen::Encuestausuario,

            Msip::Anexo,
            Msip::Orgsocial,
            Msip::Sectororgsocial,
            Msip::Persona,

            Usuario,
            :tablasbasicas
          ])
          habilidad.tablasbasicas.each do |t|
            c = Ability.tb_clase(t)
            habilidad.can(:manage, c)
          end
        end
      end
    end # initialize_cor1440_gen

    def initialize_cor1440_gen(usuario = nil)
      Cor1440Gen::Ability.initialize_cor1440_gen(self, usuario)
    end
  end # class
end   # module
