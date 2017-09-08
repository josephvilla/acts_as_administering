gem_dir = Dir[Gem::Specification.find_by_name("acts_as_administering").gem_dir + "/lib/acts_as_administrated_by/define_methods/**/*.rb"]
gem_dir.each do |f| 
  require_dependency f
  include "ActsAsAdministratedBy::DefineMethods::#{f.split('/').last.split('.').first.camelize}".constantize
end