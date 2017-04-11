module ActsAsAdministering
  module MethodBuilders
    module DefineAdministratedThingWith
      def define_method_administrated_thing_with(class_sym)
        define_method("administrated_#{class_sym.to_s.singularize}_with") do |options|
          administrated_things = send "administrated_#{class_sym}"
          thing_with = administrated_things.where(options).first
        end
      end
    end
  end
end