module ActsAsAdministering
  module DefineMethods
    module AdministratesThings

      def define_method_administrates_things(class_sym, options)
        unless options[:remote]
          define_method_administrates_things_local(class_sym, options)
        else
          define_method_administrates_things_remote(class_sym, options)
        end
      end

      private :define_method_administrates_things

    end
  end
end