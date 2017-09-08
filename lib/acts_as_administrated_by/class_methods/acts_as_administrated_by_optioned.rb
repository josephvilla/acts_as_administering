module ActsAsAdministratedBy
  module ClassMethods
    module ActsAsAdministratedByOptioned

      def acts_as_administrated_by_optioned(classes_array)
        puts "#{self}##{__method__}, classes_array:"<<" #{classes_array}".red
        acts_as_administrated_by_base classes_array[0], classes_array[1]
      end

    end
  end
end