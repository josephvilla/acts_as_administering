module ActsAsAdministering
  module DefineMethods
    module AdministratesThings

      def define_method_administrates_things(class_sym, options)
        define_method("administrates_#{class_sym}?") do 
          true
        end
      end

      private :define_method_administrates_things

    end
  end
end