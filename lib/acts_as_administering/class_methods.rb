require_dependency "acts_as_administering/class_methods/acts_as_administrating_remote"
require_dependency "acts_as_administering/class_methods/acts_as_administrating_local"
require_dependency "acts_as_administering/class_methods/acts_as_administrating_simple"
Dir["#{Gem::Specification.find_by_name("acts_as_administering").gem_dir}/lib/acts_as_administering/class_methods/**/*.rb"].each {|f| require f }

module ActsAsAdministering
  module ClassMethods
    include ActsAsAdministratingRemote
    include ActsAsAdministratingLocal
    include ActsAsAdministratingSimple
    include ActsAsAdministratingOptioned
    include ActsAsAdministratingBase

  end
end