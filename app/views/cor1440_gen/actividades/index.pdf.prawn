font_families.update("Tuffy" => {
		:normal => Cor1440Gen::Engine.root.join('app', 'assets', 'fonts', 'tuffy', 'Tuffy.ttf'),
		:italic => Cor1440Gen::Engine.root.join('app', 'assets', 'fonts', 'tuffy', 'Tuffy_Italic.ttf'),
		:bold => Cor1440Gen::Engine.root.join('app', 'assets', 'fonts', 'tuffy', 'Tuffy_Bold.ttf'),
		:bold_italic => Cor1440Gen::Engine.root.join('app', 'assets', 'fonts', 'tuffy', 'Tuffy_Bold_Italic.ttf')
		})
font "Tuffy"
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
@cuerpotabla = [@enctabla]+@cuerpotabla

table(@cuerpotabla, header: true) do
  row(0).font_style = :bold
end

