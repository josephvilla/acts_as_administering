require "acts_as_administering/engine"
require "acts_as_administrated_by"

module ActsAsAdministering

	def acts_as_administering(*classes_array)
		class_eval do

			classes_array.each do |class_sym|

				define_method("administers_" + class_sym.to_s + "?") do
					true
				end		
				
				define_method("administered_#{class_sym.to_s}") do |**options|
					send "administers_#{class_sym.to_s}?"
					@administered_things_ids = self
						.send("owned_relationships_to_"+class_sym.to_s)
						.tagged_with('admin')
						.all
						.map(&:in_relation_to_id)
					@administered_things = thing_constant(class_sym)
						.where(id: @administered_things_ids)
				end

			end

			include InstanceMethods
			include ClassMethods
		end
	end
	
	module InstanceMethods
		
		#===========================================================================
		#===========================================================================
		def administer(administered_thing)
			send "administers_#{administered_thing.class.name.underscore.pluralize}?"
			relate_to administered_thing, as: "admin"
			true
		end
		
		#===========================================================================
		#===========================================================================
		def administered(thing_key)
			@administered_things_ids = self
				.send("owned_relationships_to_"+thing_key.to_s)
				.tagged_with('admin')
				.all
				.map(&:in_relation_to_id)
			@administered_things = thing_constant(thing_key)
				.where(id: @administered_things_ids)
		end

		def administers?(thing)
			relates_to_as?(thing, 'admin')
		end
		
		#===========================================================================
		#===========================================================================
		def thing_constant(thing_key)
			thing_key.to_s.singularize.camelize.constantize
		end
		
	end # InstanceMethods

	module ClassMethods
		
	end
	
end

ActiveRecord::Base.extend ActsAsAdministering
