# frozen_string_literal: true

module Cor1440Gen
  class Engine < ::Rails::Engine
    isolate_namespace Cor1440Gen

    config.generators do |g|
      g.test_framework(:minitest, spec: true, fixture: false)
      g.fixture_replacement(:factory_girl, dir: "test/factories")
      g.assets(false)
      g.helper(false)
    end

    # Basado en
    # http://pivotallabs.com/leave-your-migrations-in-your-rails-engines/
    initializer :append_migrations do |app|
      unless app.root.to_s == root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end

    # Adaptado de http://guides.rubyonrails.org/engines.html
    config.to_prepare do |_app|
      Dir.glob(Rails.root + "app/decorators/**/*_decorator*.rb").each do |c|
        require(c)
      end
    end
  end

  mattr_accessor(:actividadg1)
  mattr_accessor(:actividadg2)
  mattr_accessor(:actividadg3)
  mattr_accessor(:actividadg4)
  mattr_accessor(:actividadg5)
  mattr_accessor(:actividadg6)
  self.actividadg1 = "Mujeres organización"
  self.actividadg2 = "Mujeres externas"
  self.actividadg3 = "Hombres organización"
  self.actividadg4 = "Hombres externos"
  self.actividadg5 = "Externos sin sexo"
  self.actividadg6 = "Externos intersexuales"

  def self.setup(&block)
    yield self
  end
end
