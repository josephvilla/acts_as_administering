require 'acts_as_administering/method_builders/define_administrated_things_method'
require 'acts_as_administering/method_builders/define_administrated_thing_with'
require_dependency 'acts_as_administering/method_builders/define_create_remote_administrated_thing'

module ActsAsAdministering
  module MethodBuilders
    include DefineAdministratedThingsMethod
    include DefineAdministratedThingWith
    include DefineCreateRemoteAdministratedThing
  end
end