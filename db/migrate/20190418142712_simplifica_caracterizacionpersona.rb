class SimplificaCaracterizacionpersona < ActiveRecord::Migration[5.2]

  # en caso de dejar proyectofinanciero en caracterizacionpersona
  # al especificar campos para xportar/importar en hoja de cálculo
  # tendrían que usarse campos de la forma formulario.proyecto.campo en
  # lugar de formulario.campo.  Que hace más compleja la interacción
  #
  # Si algo asi se necesitara, podrían más bien hacerse 2 formularios,
  # uno para cada convenio, con nombres diferentes
  def change
    remove_foreign_key :cor1440_gen_caracterizacionpersona,  
      :cor1440_gen_proyectofinanciero#, column: :proyectofinanciero_id
    remove_column :cor1440_gen_caracterizacionpersona, :proyectofinanciero_id,
      :integer
  end
end
