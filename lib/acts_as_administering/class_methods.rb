require_dependency "acts_as_administering/class_methods/acts_as_administrating_remote"

module ActsAsAdministering
  module ClassMethods
    include ActsAsAdministratingRemote

    def acts_as_administrating_simple(classes_array)
      puts "in #{self}.#{__method__}, classes_array: #{classes_array}"
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
      end

    end


  end
end