module ActsAsAdministratedBy
  module DefineMethods
    module Administrators

      module AdministratorsMethodProxy

        def <<(administrator)
          raise "in #{@__self__.class.name}.#{__method__}, expected a #{@__expected_class__}, but got a #{administrator.class.name}" unless administrator.is_a?(@__expected_class__)
          if @__as__
            relate_method = "administrated_#{@__as__.to_s.pluralize}"
          else
            relate_method = "administrated_#{@__self__.class.name.demodulize.underscore.pluralize}"
          end
          administrator.respond_to?(relate_method).tap do |responds|
            raise "#{administrator.class.name} does not administrate #{@__self__.class.name.pluralize}".red unless responds
            administrator.send(relate_method).send(:<<, @__self__)
          end
        end

        def remove(administrator)
          raise "in #{@__self__.class.name}.#{__method__}, expected a #{@__expected_class__}, but got a #{administrator.class.name}" unless administrator.is_a?(@__expected_class__)          
          stop_relating_method = "stop_relating_to_#{@__self__.class.name.underscore}"
          administrator.respond_to?(stop_relating_method).tap do |responds|
            raise "#{administrator.class.name} does not administrate #{@__self__.class.name.pluralize}" unless responds
            administrator.send(stop_relating_method, @__self__, as: 'admin')
          end
        end

        def ids
          self.map(&:id)
        end
        
      end

      module AdminsIncludeProxy
        def include?(args)
          args_ids = [args] if args.is_a?(Integer)
          args_ids ||= args if (args_ids.blank? && args.is_a?(Array) && args.first.is_a?(Integer))
          args_ids ||= [args.id] if (args_ids.blank? && args.respond_to?(:id))
          args_ids ||= args.map(&:id) if (args_ids.blank? && args.first.respond_to?(:id))
          !(self.ids & args_ids).blank?
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
              administrators.extend(AdminsIncludeProxy) if administrators.is_a?(Array)
              administrators.instance_variable_set(:@__expected_class__, expected_class)
              administrators.instance_variable_set(:@__self__, self)
              administrators.instance_variable_set(:@__as__, options[:as])
              administrators.instance_variable_set(:@__class_sym__, class_sym)
            end
          end
        end
      end

      private :define_method_administrators
      
    end
  end
end