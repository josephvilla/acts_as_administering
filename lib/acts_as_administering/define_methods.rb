#require 'acts_as_administering/define_methods/administrate_this_thing'
#require 'acts_as_administering/define_methods/administrate_this_thing_remote'
gem_dir = Dir[Gem::Specification.find_by_name("acts_as_administering").gem_dir + "/lib/acts_as_administering/define_methods/**/*.rb"]
gem_dir.each do |f| 
  require_dependency f
  include "ActsAsAdministering::DefineMethods::#{f.split('/').last.split('.').first.camelize}".constantize
end