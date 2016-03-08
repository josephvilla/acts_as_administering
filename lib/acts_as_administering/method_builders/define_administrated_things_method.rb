module ActsAsAdministering
  module MethodBuilders
    module DefineAdministratedThingsMethod

      def define_administrated_things_method(class_sym)
        define_method("administrated_#{class_sym.to_s}") do |**options|
          @administrated_things_ids = self
            .send("owned_relationships_to_"+class_sym.to_s)
            .tagged_with('admin')
            .all
            .map(&:in_relation_to_id)
          @administrated_things = thing_constant(class_sym).where(id: @administrated_things_ids)
          @administrated_things.each{|t| puts "in #{self.class}.#{__method__}, t.inspect: #{t.inspect}"}
          @administrated_things.all
        end
      end # administrated_things

    end
  end  
end