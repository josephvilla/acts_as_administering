module ActsAsAdministering
  module DefineMethods
    module AdministratesThingsLocal

      def define_method_administrates_things_local(class_sym, options)
        define_method("administrates_#{class_sym}?") do 
          true
        end
      end

      private :define_method_administrates_things_local

    end
  end
end