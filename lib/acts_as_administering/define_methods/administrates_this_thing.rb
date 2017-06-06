module ActsAsAdministering
  module DefineMethods
    module AdministratesThisThing

      def define_method_administrates_this_thing(class_sym, options)
        unless options[:remote]
          define_method_administrates_this_thing_local(class_sym, options)
        else
          define_method_administrates_this_thing_remote(class_sym, options)
        end
      end

      private :define_method_administrates_this_thing

    end
  end
end