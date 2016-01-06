module ActsAsAdministratedBy
  module ClassMethods
    module AdministratedBy
      def administrated_by(person, options={})
        if self < ActiveRecord::Base
          in_relation_to_ids = ActsAsRelatingTo::Relationship.tagged_with('admin').where(owner_type: person.class.name, owner_id: person.id, in_relation_to_type: self.name).map{|r|r.in_relation_to_id}
          self.find(in_relation_to_ids)
        else
          @caller = __method__.to_s
          @person = person
          @options = options[self.to_s.demodulize.underscore.singularize]
          #puts "in #{self}.#{__method__}, @person.inspect: #{@person.inspect}"
          #puts "in #{self}.#{__method__}, @options: #{@options}"
          res = generic('get')
          #puts "in #{self}.#{__method__}, res: #{res}" unless res.is_a?(String)
          #puts "in #{self}.#{__method__}, something went wrong on the server" if res.is_a?(String)
          #raise __method__.to_s
        end
      end

      def administrated_by_url
        @url = "#{self::APP_PROVIDER.url}/#{my_object_name.pluralize}/administrated_by/#{@person.id}"
        @url = @url + "?#{@options.to_query(self.to_s.demodulize.underscore.singularize)}" if @options
        #puts @url
        @url
      end

    end
  end
end