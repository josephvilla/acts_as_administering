module ActsAsAdministering
  module ClassMethods
    module ActsAsAdministratingBase

      def acts_as_administrating_base(class_sym, options={})
        location = (options[:remote] ? "_remote" : "")
        if options[:remote]
          acts_as_administrating_remote class_sym, options
        else
          acts_as_administrating_local class_sym, options
        end

        #define_method_administrated_thing_with class_sym
        [
          :administrate_this_thing,
          :administrates_this_thing,
          #:administrates_things,
          :stop_administrating_this_thing
        ].each do |method_key|
          send "define_method_#{method_key}#{location}", class_sym, options
        end

      end
      
    end
  end
end