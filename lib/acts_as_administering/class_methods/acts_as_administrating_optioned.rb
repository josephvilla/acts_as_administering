module ActsAsAdministering
  module ClassMethods
    module ActsAsAdministratingOptioned

      def acts_as_administrating_optioned(spec)
        class_sym = spec[0]
        options = spec.pop
        acts_as_administrating_base class_sym, options
      end

    end
  end
end