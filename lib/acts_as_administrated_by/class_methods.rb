["shared","class"].each do |konstant_type|
  file_dir = "#{Gem::Specification.find_by_name("acts_as_administering").gem_dir}/lib/acts_as_administrated_by/#{konstant_type}_methods/**/*.rb"
  Dir[file_dir].each do |f| 
    require_dependency f 
    konstant_name = f.split('/').last.split('.').first.camelize
    include "ActsAsAdministratedBy::#{konstant_type.camelize}Methods::#{konstant_name}".constantize
  end
end

=begin
require 'acts_as_administrated_by/class_methods/administrated_by'

module ActsAsAdministratedBy
  module ClassMethods
    include AdministratedBy
  end
end
=end