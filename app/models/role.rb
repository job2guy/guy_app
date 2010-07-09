class Role < ActiveRecord::Base
  validates_presence_of :name,:title
  validates_uniqueness_of :name,:title
end
