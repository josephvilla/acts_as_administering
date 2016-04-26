module ActsAsAdministering
  module MethodBuilders
    module DefineAdministratedThingWith
      def define_method_administrated_thing_with(class_sym)
        define_method("administrated_#{class_sym.to_s.singularize}_with") do |options|
          administrated_things = send "administrated_#{class_sym}"
          #puts "in #{self}.#{__method__}, administrated_things: #{administrated_things}"
          thing_with = administrated_things.where(options).first
          #HashWithIndifferentAccess.new(success: true, ret: thing_with)
        end
      end
    end
  end
end