module ActsAsAdministratedBy
  module ClassMethods
    module ActsAsAdministratedByBase

      def acts_as_administrated_by_base(class_sym, options)
        puts "#{self}##{__method__}, class_sym:"<<" #{class_sym}".red
        puts "#{self}##{__method__}, options:"<<" #{options}".light_blue
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