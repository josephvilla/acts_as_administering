module ActsAsAdministratedBy
  module DefineMethods
    module Administrators

      module AdministratorsMethodProxy

        def <<(administrator)
          raise "in #{@__self__.class.name}.#{__method__}, expected a #{@expected_class}, but got a #{administrator.class.name}" unless administrator.is_a?(@expected_class)
          relate_method = "relate_to_#{@__self__.class.name.underscore}"
          administrator.respond_to?(relate_method).tap do |responds| 
            raise "#{administrator.class.name} does not administer #{@__self__.class.name.pluralize}" unless responds
            administrator.send(relate_method, @__self__, as: 'admin')
          end
        end

        def remove(administrator)
          raise "in #{@__self__.class.name}.#{__method__}, expected a #{@expected_class}, but got a #{administrator.class.name}" unless administrator.is_a?(@expected_class)          
          stop_relating_method = "stop_relating_to_#{@__self__.class.name.underscore}"
          administrator.respond_to?(stop_relating_method).tap do |responds|
            raise "#{administrator.class.name} does not administer #{@__self__.class.name.pluralize}" unless responds
            administrator.send(stop_relating_method, @__self__, as: 'admin')
          end
        end
        
      end

      def define_method_administrators(class_sym, options)
        expected_class = (options[:class_name] || class_sym.to_s.camelize.singularize).constantize
        unless method_defined?(:administrators)
          unless method_defined?("#{class_sym}_that_relate_to_me")
            class_eval do 
              acts_as_relating_to class_sym, options
            end
          end
          define_method(:administrators) do 
            send("#{class_sym}_that_relate_to_me", as: 'admin').tap do |administrators|
              return administrators if administrators.is_a?(AdministratorsMethodProxy)
              administrators.extend(AdministratorsMethodProxy)
              administrators.instance_variable_set(:@expected_class, expected_class)
              administrators.instance_variable_set(:@__self__, self)
            end
          end
        end
      end

      private :define_method_administrators
      
    end
  end
end