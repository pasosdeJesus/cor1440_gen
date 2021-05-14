class ProyectoPorOmision < ActiveRecord::Migration[6.1]
  def change
    # Proyectos que lo tengan se agregan automaticamente a nuevas
    # actividades, siempre que se creen durante el periodo de
    # vigencia y que el usuario que cree la actividad este en el equipo
    # del proyecto.
    add_column :cor1440_gen_proyectofinanciero, :poromision, :boolean
  end
end
