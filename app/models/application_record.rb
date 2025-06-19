class ApplicationRecord < ActiveRecord::Base
self.primary_key = "uuid"
  primary_abstract_class
end
