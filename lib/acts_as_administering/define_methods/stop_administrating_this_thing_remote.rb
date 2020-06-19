module ActsAsAdministering
  module DefineMethods
    module StopAdministratingThisThingRemote

      def define_method_stop_administrating_this_thing_remote(class_sym, options={})
        singular = class_sym.to_s.singularize
        expected_class_name = options[:class_name] || singular.camelize
        expected_class = expected_class_name.constantize

        define_method("stop_administrating_this_#{singular}_url") do
          @url = app_provider.uri.clone << '/api/' << api_version
          @url << "/people/#{self.id}"
          @url << "/administrated_thing/stop_administrating"
          append_query
        end

        define_method("stop_administrating_this_#{singular}") do |thing|
          @called_by = "stop_administrating_this_#{singular}"
          @query = {thing_type: singular, singular => {id: thing.id}}
          if thing.is_a?(expected_class)
            generic('put')
          else
            raise "in #{my_klass}.#{__method__}, expected a #{expected_class_name}, but got a #{thing.class.name}"
          end
        end
      end

      private :define_method_stop_administrating_this_thing_remote

    end
  end
end