require 'acts_as_administering/method_builders/define_administrated_things_method'
require 'acts_as_administering/method_builders/define_administrated_thing_with'

module ActsAsAdministering
  module MethodBuilders
    include DefineAdministratedThingsMethod
    include DefineAdministratedThingWith
  end
end