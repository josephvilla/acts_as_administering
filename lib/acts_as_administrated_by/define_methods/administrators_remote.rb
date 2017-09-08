module ActsAsAdministratedBy
  module DefineMethods
    module AdministratorsRemote

      def define_method_administrators_remote(class_sym, options)
        collection_name = self.name.demodulize.underscore.pluralize

        if options[:api_version]
          api_version = "/api/v#{options[:api_version]}"
        else
          api_version = app_provider.url_base
        end

        define_method(:administrators_url) do 
          @url = app_provider.uri.clone << api_version
          @url = @url << "/#{collection_name}/#{self.id}/administrators"
        end

        define_method(:administrators) do 
          @called_by = __method__.to_s
          generic('get')
        end

      end

      private :define_method_administrators_remote
      
    end
  end
end