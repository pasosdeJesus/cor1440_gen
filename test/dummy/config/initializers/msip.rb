# frozen_string_literal: true

require "cor1440_gen/version"

Msip.setup do |config|
  config.ruta_anexos = "#{Rails.root.join("archivos/anexos")}"
  config.ruta_volcados = "#{Rails.root.join("archivos/bd")}"
  config.titulo = "Cor1440Gen " + Cor1440Gen::VERSION

  config.descripcion = "Motor para proyectos y actividades con metodología de marco lógico"
  config.codigofuente = "https://gitlab.com/pasosdeJesus/cor1440_gen"
  config.urlcontribuyentes = "https://gitlab.com/pasosdeJesus/cor1440_gen/-/graphs/main"
  config.urlcreditos = "https://gitlab.com/pasosdeJesus/cor1440_gen/blob/main/CREDITOS.md"
  config.urllicencia = "https://gitlab.com/pasosdeJesus/cor1440_gen/blob/main/LICENCIA.md"
  config.agradecimientoDios = "<p>
Agradecemos a Dios que es Dios de orden
</p>
<blockquote>
<p>
Pero hágase todo decentemente y con orden.
</p>
<p>I Corintios 14:40</p>
</blockquote>".html_safe
end
