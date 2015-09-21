module ActsAsAdministering
  class Engine < ::Rails::Engine
    isolate_namespace ActsAsAdministering
    
    config.generators do |g|
      g.test_framework      :rspec,        :fixture => false
      g.fixture_replacement :factory_girl, :dir => 'spec/factories'
      g.assets false
      g.helper false
    end

		# this initializer makes the engine migrations available to the main_app while leaving
		# the migrations in the engine. 
	
		initializer :append_migrations do |app|
      unless app.root.to_s.match root.to_s
        config.paths["db/migrate"].expanded.each do |expanded_path|
          app.config.paths["db/migrate"] << expanded_path
        end
      end
    end #initializer
    
  end
end
