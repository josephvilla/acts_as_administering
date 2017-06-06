module ActsAsAdministering
  module ClassMethods
    module ActsAsAdministratingLocal
      def acts_as_administrating_local(class_sym, options)
        options[:as] = 'admin'
        things_klass_name = class_sym.to_s.singularize.camelize

        acts_as_relating_to class_sym, options

        define_method("administrated_#{class_sym}") do 
          send "#{class_sym.to_s}_i_relate_to", as: 'admin'
        end
      end
    end
  end
end