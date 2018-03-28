module ActsAsAdministratedBy
  module ClassMethods
    module ActsAsAdministratedBySimple

      def acts_as_administrated_by_simple(classes_array)
        classes_array.each do |class_sym|
          acts_as_administrated_by_base class_sym
        end
      end

    end
  end
end