
font_size 16
text("Reporte de " + @actividades.model_name.human.pluralize.titleize)
font_size 12
text("Generado el " + Time.now.strftime("%Y-%m-%d") + " a las " + 
  Time.now.strftime("%H:%M"))

f = []
if @buscodigo && @buscodigo != ''
  f += ["id=#{@buscodigo}"]
end
if @fechaini && @fechaini != ''
  f += ["fecha>=#{@fechaini}"]
end
if @fechafin && @fechafin != ''
  f += ["fecha<=#{@fechafin}"]
end
if @busoficina && @busoficina != ''
  f += ["oficina=#{@busoficina}"]
end
if @busnombre && @busnombre != ''
  f += ["nombre=#{@busnombre}"]
end
if @busarea && @busarea != ''
  f += ["area=#{@busarea}"]
end
if @bustipo && @bustipo != ''
  f += ["tipo=#{@bustipo}"]
end
if @busobjetivo && @busobjetivo!= ''
  f += ["objetivo=#{@busobjetivo}"]
end
if @busproyecto && @busproyecto!= ''
  f += ["proyecto=#{@busproyecto}"]
end
if f != [] 
  text("Filtro: " + f.join("; "))
end
move_down  30

font_size 8
@cuerpotabla = [@enctabla]
@actividades.try(:each) do |actividad| 
  r=actividad.actividad_rangoedadac.map { |i| 
    (i.ml ? i.ml : 0) + (i.mr ? i.mr : 0) +
      (i.fl ? i.fl : 0) + (i.fr ? i.fr : 0)
  } 

  @cuerpotabla += [[actividad.id,
    actividad.fecha,
      actividad.oficina ? actividad.oficina.nombre : "",
        actividad.nombre,
    actividad.actividadareas.inject("") { |memo, i| 
      (memo == "" ? "" : memo + "; ") + i.nombre
    } ,
    actividad.actividadtipo.inject("") { |memo, i| 
      (memo == "" ? "" : memo + "; ") + i.nombre
    },
    actividad.objetivo,
    actividad.proyecto.inject("") { |memo, i| 
      (memo == "" ? "" : memo + "; ") + i.nombre 
    },
    r.reduce(:+),
  ]]
end

table(@cuerpotabla, header: true) do
  row(0).font_style = :bold
end

