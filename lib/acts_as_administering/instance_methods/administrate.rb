module ActsAsAdministering
  module InstanceMethods
    module Administrate

      def administrate(thing)
        puts "in #{self.class}.#{__method__}"
        relate_to thing, as: "admin"
      end

    end
  end
end