# encoding: UTF-8
class Ability  < Cor1440Gen::Ability

  def acciones_plantillas 
    {'Actividades' => 
     { 
       campos: [
         'ultimaatencion_mes', 'ultimaatencion_fecha', 
         'contacto_nombres', 'contacto_apellidos', 'contacto_identificacion', 'contacto_sexo', 'contacto_edad_ultimaatencion', 'contacto_etnia',
         'beneficiarios_0_5', 'beneficiarios_6_12',
         'beneficiarios_13_17', 'beneficiarios_18_26',
         'beneficiarios_27_59', 'beneficiarios_60_',
         'beneficiarias_0_5', 'beneficiarias_6_12',
         'beneficiarias_13_17', 'beneficiarias_18_26',
         'beneficiarias_27_59', 'beneficiarias_60_',
         'ultimaatencion_derechosvul', 'ultimaatencion_as_humanitaria',
         'ultimaatencion_as_juridica', 'ultimaatencion_otros_ser_as', 
         'ultimaatencion_descripcion_at',
         'oficina' ],
         controlador: 'Cor1440Gen::ActividadesController'
     }
    }
  end

  # Autorizacion con CanCanCan
  def initialize(usuario = nil)
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
        can :read, Cor1440Gen::Informe
        can :read, Cor1440Gen::Actividad
        can :new, Cor1440Gen::Actividad
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :read, Cor1440Gen::Proyectofinanciero
      when Ability::ROLCOOR
        can :manage, Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Informe
        can [:update, :create, :destroy], Cor1440Gen::Actividad, 
          oficina: { id: usuario.oficina_id}
        can :new, Usuario
        can [:read, :manage], Usuario, oficina: { id: usuario.oficina_id}
        can :read, Cor1440Gen::Proyectofinanciero
      when Ability::ROLINV
        cannot :buscar, Sip::Actividad
        can :read, Sip::Actividad
      when Ability::ROLADMIN, Ability::ROLDIR
        can :manage, Cor1440Gen::Proyectofinanciero
        can :manage, Cor1440Gen::Financiador
        can :manage, Cor1440Gen::Actividad
        can :manage, Cor1440Gen::Informe
        can :manage, Heb412Gen::Doc
        can :manage, :tablasbasicas
        can :manage, Usuario
        can :manage, :tablasbasicas
        tablasbasicas.each do |t|
          c = Ability.tb_clase(t)
          can :manage, c
        end
      end
    end
  end

end

