module ActsAsAdministering
  module ClassMethods
    module ActsAsAdministratingLocal
      
      module RelationShovelProxy
        def <<(thing_to_administrate)
          if thing_to_administrate.is_a?(@expected_class)
            ActiveRecord::Base.transaction do 
              begin
                @__self__.relate_to thing_to_administrate, as: 'admin'
              end
            end
          else
            raise "in #{self.class.name}.#{__method__}, expected a #{@expected_class}, but got a #{thing_to_administrate.class.name}"
          end
        end
      end

      def acts_as_administrating_local(class_sym, options)
        things_klass_name = options[:class_name]
        things_klass_name ||= class_sym.to_s.singularize.camelize

        acts_as_relating_to class_sym, options

        define_method("administrated_#{class_sym}") do 
          send("#{class_sym}_i_relate_to", as: 'admin').tap do |relation|
            return relation if relation.is_a?(RelationShovelProxy)
            relation.tap do |r|
              r.extend(RelationShovelProxy)
              r.instance_variable_set(:@expected_class, things_klass_name.constantize)
              r.instance_variable_set(:@__self__, self)
            end
          end
        end
      end
      
    end
  end
end