module ActsAsAdministering
  module DefineMethods
    module AdministrateThisThingRemote

      def define_method_administrate_this_thing_remote(class_sym, options={})
        singular = class_sym.to_s.singularize
        method_name = "administrate_this_#{singular}"

        define_method("#{method_name}_url") do
          my_klass.url = my_klass::APP_PROVIDER.url
          my_klass.url = "#{my_klass.url}/#{my_object_name.pluralize}/#{self.id}"
          my_klass.url = "#{my_klass.url}/administrated_#{class_sym}/#{@thing.id}"
        end

        define_method(method_name) do |thing|
          @thing = thing
          my_klass.called_by = method_name
          remote_result = generic('put')
          #puts "in #{my_klass}.#{__method__}, remote_result: #{remote_result}"
          @thing = nil
          remote_result[:success] ? remote_result[:success] : remote_result[:errors]
        end

      end

    end
  end
end