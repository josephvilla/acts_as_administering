module ActsAsAdministering
  module DefineMethods
    module AdministratesThisThingLocal

      def define_method_administrates_this_thing_local(class_sym, options)
        singular = class_sym.to_s.singularize
        expected_class_name = options[:class_name] || singular.camelize
        expected_class = expected_class_name.constantize

        define_method("administrates_this_#{singular}?") do |thing|
          if thing.is_a?(expected_class)
            self.relates_to_as?(thing, 'admin')
          else
            raise "in #{my_klass}.#{__method__}, expected a #{expected_class_name}, but got a #{thing.class.name}"
          end
        end
      end

      private :define_method_administrates_this_thing_local
      
    end
  end
end