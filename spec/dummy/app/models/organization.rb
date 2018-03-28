class Organization < ActiveRecord::Base
  acts_as_administrated_by :people
end
