require 'acts_as_administrated_by/instance_methods/administrator_ids'
require 'acts_as_administrated_by/instance_methods/is_administrator'

module ActsAsAdministratedBy
  module InstanceMethods
    include AdministratorIds
    include IsAdministrator
  end
end