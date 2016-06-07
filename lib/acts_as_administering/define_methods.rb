#require 'acts_as_administering/define_methods/administrate_this_thing'
#require 'acts_as_administering/define_methods/administrate_this_thing_remote'
Dir[Gem::Specification.find_by_name("acts_as_administering").gem_dir + "/lib/acts_as_administering/define_methods/**/*.rb"].each{|f| require_dependency f}

module ActsAsAdministering
  module DefineMethods
    include AdministrateThisThing
    include AdministrateThisThingRemote
    include AdministrateThisThingLocal
  end
end