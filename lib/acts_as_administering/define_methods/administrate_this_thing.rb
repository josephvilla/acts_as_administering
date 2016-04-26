module ActsAsAdministering
  module DefineMethods
    module AdministrateThisThing

      def define_method_administrate_this_thing(class_sym, options={})
        singular = class_sym.to_s.singularize
        expected_class_name = options[:class_name]
        expected_class_name ||= singular.camelize
        expected_class = expected_class_name.constantize

        define_method("administrate_this_#{singular}") do |thing|
          if thing.is_a?(expected_class)
            raise "in #{my_klass}.#{__method__}, NOT IMPLEMENTED"
          else
            raise "in #{my_klass}.#{__method__}, expected a #{expected_class_name}, but got a #{thing.class.name}"
          end
        end 

      end

      private :define_method_administrate_this_thing

    end
  end
end