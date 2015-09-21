class Person < ActiveRecord::Base
	acts_as_relating_to :organizations
	acts_as_administering :organizations
end
