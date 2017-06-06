require_dependency 'acts_as_administering/define_methods/administrate_this_thing_local'
require_dependency 'acts_as_administering/define_methods/administrate_this_thing_remote'

module ActsAsAdministering
  module DefineMethods
    module AdministrateThisThing

      def define_method_administrate_this_thing(class_sym, options={})
        unless options[:remote]
          define_method_administrate_this_thing_local(class_sym, options)
        else
          define_method_administrate_this_thing_remote(class_sym, options)
        end
      end

      private :define_method_administrate_this_thing

    end
  end
end