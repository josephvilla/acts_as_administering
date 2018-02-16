module ActsAsAdministering
  module MethodBuilders
    module DefineCreateRemoteAdministratedThing
      def define_create_remote_administrated_thing(class_sym, options={})

        thing_object_name = class_sym.to_s.singularize

        define_method("create_administrated_#{thing_object_name}_url") do
          @url = "#{my_klass.app_provider.url}/people/#{self.id}/administrated/#{thing_object_name.pluralize}"
          append_query(thing_object_name)
        end

        define_method("create_administrated_#{thing_object_name}") do |args|
          @called_by = "create_administrated_#{class_sym.to_s.singularize}"
          @query = args
          res = generic('post').with_indifferent_access
          options[:class_name].constantize.new(res)
        end

      end
    end
  end
end