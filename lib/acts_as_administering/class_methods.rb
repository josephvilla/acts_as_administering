require_dependency "acts_as_administering/class_methods/acts_as_administrating_remote"
require_dependency "acts_as_administering/class_methods/acts_as_administrating_local"
require_dependency "acts_as_administering/class_methods/acts_as_administrating_simple"

["shared","class"].each do |konstant_type|
  file_dir = "#{Gem::Specification.find_by_name("acts_as_administering").gem_dir}/lib/acts_as_administering/#{konstant_type}_methods/**/*.rb"
  Dir[file_dir].each do |f| 
    require_dependency f 
    konstant_name = f.split('/').last.split('.').first.camelize
    include "ActsAsAdministering::#{konstant_type.camelize}Methods::#{konstant_name}".constantize
  end
end
=begin
module ActsAsAdministering
  module ClassMethods
    include ActsAsAdministratingRemote
    include ActsAsAdministratingLocal
    include ActsAsAdministratingSimple
    include ActsAsAdministratingOptioned
    include ActsAsAdministratingBase

  end
end
=end