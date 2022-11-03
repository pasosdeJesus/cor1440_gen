require 'cor1440_gen/version'

Sip.setup do |config|
  config.ruta_anexos = "#{Rails.root}/archivos/anexos"
  config.ruta_volcados = "#{Rails.root}/archivos/bd"
  # En heroku los anexos son super-temporales
  if !ENV["HEROKU_POSTGRESQL_GREEN_URL"].nil?
    config.ruta_anexos = "#{Rails.root}/tmp/"
  end
  config.titulo = "Cor1440Gen " + Cor1440Gen::VERSION

  config.descripcion = "Motor para proyectos y actividades con metodología de marco lógico"
  config.codigofuente = "https://github.com/pasosdeJesus/cor1440_gen"
  config.urlcontribuyentes = "https://github.com/pasosdeJesus/cor1440_gen/graphs/contributors"
  config.urlcreditos = "https://github.com/pasosdeJesus/cor1440_gen/blob/master/CREDITOS.md"
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
