require_dependency "acts_as_administering/class_methods/acts_as_administrating_remote"
require_dependency "acts_as_administering/class_methods/acts_as_administrating_local"

module ActsAsAdministering
  module ClassMethods
    include ActsAsAdministratingRemote
    include ActsAsAdministratingLocal

    def acts_as_administrating_simple(classes_array)
      puts "in #{self}.#{__method__}, classes_array: #{classes_array}"
      classes_array.each do |class_sym|
        acts_as_administrating_base class_sym
      end
    end

    def acts_as_administrating_optioned(spec)
      puts "in #{self}.#{__method__}, spec: #{spec}"
      class_sym = spec[0]
      options = spec.pop
      acts_as_administrating_base class_sym, options
    end

    def acts_as_administrating_base(class_sym, options={})
      if options[:remote]
        acts_as_administrating_remote class_sym, options
      else
        acts_as_administrating_local class_sym, options
      end
      #define_method_administrated_thing_with class_sym

    end


  end
end