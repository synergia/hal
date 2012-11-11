class Category < ActiveRecord::Base
  attr_accessible :name

  validates_presence_of :name

  default_scope order("name ASC")

  has_many :items
  # has_many :resources
end
