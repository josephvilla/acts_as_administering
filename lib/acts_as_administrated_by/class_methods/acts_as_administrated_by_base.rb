module ActsAsAdministratedBy
  module ClassMethods
    module ActsAsAdministratedByBase

      def acts_as_administrated_by_base(class_sym, options={})
        location = (options[:remote] ? "_remote" : "")
        [
          :administrators
        ].each do |method_key|
          send "define_method_#{method_key}#{location}", class_sym, options
        end        
      end

    end
  end
end