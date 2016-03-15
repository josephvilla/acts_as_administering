module ActsAsAdministering
  module ClassMethods
    module ActsAsAdministratingRemote

      def acts_as_administrating_remote(class_sym, options)
        thing_name = class_sym.to_s.singularize

        define_create_remote_administrated_thing(class_sym, options)

        define_method("administrated_#{class_sym}_url") do
          my_klass.url = "#{my_klass::APP_PROVIDER.url}/#{my_object_name.pluralize}/#{self.id}/administrated/#{class_sym.to_s.pluralize}"
          append_query("#{class_sym.to_s.singularize}")
        end

        define_method("administrated_#{class_sym.to_s}") do |**args|
          my_klass.called_by = "administrated_#{class_sym.to_s}"
          my_klass.query = args unless args.empty?
          res = generic('get')
          if res.is_a?(Array)
            return_klass = options[:class_name].constantize
            return_array = []
            res.each do |item|
              return_array << return_klass.new(item)
            end
            return return_array
          else
            return res
          end
        end

        define_method("administrated_#{thing_name}_with") do |args|
          things = send "administrated_#{class_sym}", args
          things[0]
        end

      end
      
    end
  end
end