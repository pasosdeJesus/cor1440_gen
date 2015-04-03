# Be sure to restart your server when you modify this file.

# Add new inflection rules using the following format. Inflections
# are locale specific, and you may define rules for as many different
# locales as you wish. All of these examples are active by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.plural /^(ox)$/i, '\1en'
#   inflect.singular /^(ox)en/i, '\1'
#   inflect.irregular 'person', 'people'
#   inflect.uncountable %w( fish sheep )
# end

# These inflection rules are supported but not enabled by default:
# ActiveSupport::Inflector.inflections(:en) do |inflect|
#   inflect.acronym 'RESTful'
# end
ActiveSupport::Inflector.inflections do |inflect|
	inflect.irregular 'actosjr', 'actosjr'
	inflect.irregular 'aslegalrespuesta', 'aslegalrespuesta'
	inflect.irregular 'aspsicosocialrespuesta', 'aspsicosocialrespuesta'
	inflect.irregular 'ayudaestado', 'ayudasestado'
	inflect.irregular 'ayudaestadorespuesta', 'ayudaestadorespuesta'
	inflect.irregular 'ayudasjr', 'ayudassjr'
	inflect.irregular 'ayudasjrrespuesta', 'ayudasjrrespuesta'
	inflect.irregular 'derechorespuesta', 'derechorespuesta'
	inflect.irregular 'emprendimientorespuesta', 'emprendimientorespuesta'
	inflect.irregular 'motivosjr', 'motivossjr'
	inflect.irregular 'motivosjrrespuesta', 'motivosjrrespuesta'
	inflect.irregular 'progestadorespuesta', 'progestadorespuesta'
	inflect.irregular 'proteccion', 'protecciones'
	inflect.irregular 'regionsjr', 'regionessjr'
	inflect.irregular 'respuesta', 'respuesta'
end
