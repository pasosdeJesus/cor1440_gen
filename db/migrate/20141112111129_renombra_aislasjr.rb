class RenombraAislasjr < ActiveRecord::Migration
  def change
    rename_table :acreditacion, :cor440_gen_acreditacion
    rename_table :actosjr, :cor440_gen_actosjr
    rename_table :actualizacionbase, :cor440_gen_actualizacionbase
    rename_table :aslegal, :cor440_gen_aslegal
    rename_table :aslegal_respuesta, :cor440_gen_aslegal_respuesta
    rename_table :ayudaestado, :cor440_gen_ayudaestado
    rename_table :ayudaestado_respuesta, :cor440_gen_ayudaestado_respuesta
    rename_table :ayudasjr, :cor440_gen_ayudasjr
    rename_table :ayudasjr_respuesta, :cor440_gen_ayudasjr_respuesta
    rename_table :casosjr, :cor440_gen_casosjr
    rename_table :clasifdesp, :cor440_gen_clasifdesp
    rename_table :comosupo, :cor440_gen_comosupo
    rename_table :declaroante, :cor440_gen_declaroante
    rename_table :derecho, :cor440_gen_derecho
    rename_table :derecho_respuesta, :cor440_gen_derecho_respuesta
    rename_table :desplazamiento, :cor440_gen_desplazamiento
    rename_table :etiqueta_usuario, :cor440_gen_etiqueta_usuario
    rename_table :idioma, :cor440_gen_idioma
    rename_table :inclusion, :cor440_gen_inclusion
    rename_table :instanciader, :cor440_gen_instanciader
    rename_table :mecanismoder, :cor440_gen_mecanismoder
    rename_table :modalidadtierra, :cor440_gen_modalidadtierra
    rename_table :motivoconsulta, :cor440_gen_motivoconsulta
    rename_table :motivosjr, :cor440_gen_motivosjr
    rename_table :motivosjr_respuesta, :cor440_gen_motivosjr_respuesta
    rename_table :personadesea, :cor440_gen_personadesea
    rename_table :progestado, :cor440_gen_progestado
    rename_table :progestado_respuesta, :cor440_gen_progestado_respuesta
    rename_table :proteccion, :cor440_gen_proteccion
    rename_table :regimensalud, :cor440_gen_regimensalud
    rename_table :resagresion, :cor440_gen_resagresion
    rename_table :respuesta, :cor440_gen_respuesta
    rename_table :rolfamilia, :cor440_gen_rolfamilia
    rename_table :statusmigratorio, :cor440_gen_statusmigratorio
    rename_table :tipodesp, :cor440_gen_tipodesp
    rename_table :victimasjr, :cor440_gen_victimasjr
  end
end
