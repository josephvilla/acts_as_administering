module ActsAsAdministering
  module DefineMethods
    module AdministrateThisThing

      def define_method_administrate_this_thing(class_sym, options={})

        unless options[:remote]
          define_method_administrate_this_thing_local(class_sym, options)
        else
          define_method_administrate_thing_thing_remote(class_sym, options)
        end

      end

      private :define_method_administrate_this_thing,
              :define_method_administrate_this_thing_local,
              :define_method_administrate_thing_thing_remote

    end
  end
end