module ActsAsAdministering
  module ClassMethods
    module ActsAsAdministratingSimple

      def acts_as_administrating_simple(classes_array)
        classes_array.each do |class_sym|
          acts_as_administrating_base class_sym
        end
      end

    end
  end
end