module ActsAsAdministratedBy
  module ClassMethods
    module ActsAsAdministratedByOptioned

      def acts_as_administrated_by_optioned(classes_array)
        acts_as_administrated_by_base classes_array[0], classes_array[1]
      end

    end
  end
end