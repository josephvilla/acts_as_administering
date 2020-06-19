module ActsAsAdministering
  module DefineMethods
    module AdministratesThisThingRemote

      def define_method_administrates_this_thing_remote(class_sym, options)
        singular = class_sym.to_s.singularize
        expected_class_name = options[:class_name] || singular.camelize
        expected_class = expected_class_name.constantize

        define_method("administrates_this_#{singular}_url") do
          @url = app_provider.uri.clone << '/api/' << api_version
          @url << "/people/#{self.id}"
          @url << "/administrates_this"
          append_query
        end

        define_method("administrates_this_#{singular}?") do |thing|
          @called_by = "administrates_this_#{singular}"
          @query = {thing_type: singular, singular => {id: thing.id}}
          if thing.is_a?(expected_class)
            return generic('get').tap{|x| puts "in " << "#{self.class.name}.#{__method__}".white << ", " << "x: " << "#{x}".yellow}
          else
            raise "in #{my_klass}.#{__method__}, expected a #{expected_class_name}, but got a #{thing.class.name}"
          end
        end
      end

      private :define_method_administrates_this_thing_remote
      
    end
  end
end