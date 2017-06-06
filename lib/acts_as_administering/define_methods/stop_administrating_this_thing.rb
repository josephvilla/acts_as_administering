module ActsAsAdministering
  module DefineMethods
    module StopAdministratingThisThing

      def define_method_stop_administrating_this_thing(class_sym, options={})
        unless options[:remote]
          define_method_stop_administrating_this_thing_local(class_sym, options)
        else
          define_method_stop_administrating_this_thing_remote(class_sym, options)
        end
      end

      private :define_method_stop_administrating_this_thing

    end
  end
end