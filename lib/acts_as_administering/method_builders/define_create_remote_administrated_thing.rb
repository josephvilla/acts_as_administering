module ActsAsAdministering
  module MethodBuilders
    module DefineCreateRemoteAdministratedThing
      def define_create_remote_administrated_thing(class_sym, options={})

        thing_object_name = class_sym.to_s.singularize

        define_method("create_administrated_#{thing_object_name}_url") do
          my_klass.url = "#{my_klass::APP_PROVIDER.url}/people/#{self.id}/administrated/#{thing_object_name.pluralize}"
          append_query
        end

        define_method("create_administrated_#{thing_object_name}") do |args|
          my_klass.called_by = "create_administrated_#{class_sym.to_s.singularize}"
          my_klass.query = args
          res = generic('post').with_indifferent_access
          options[:class_name].constantize.new(res)
=begin          
          unless res[:errors]
            options[:class_name].constantize.new(res)
          else
            res
          end
=end          
        end
      end
    end
  end
end