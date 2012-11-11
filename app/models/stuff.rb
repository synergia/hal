class Stuff < ActiveRecord::Base
  attr_accessible :category_id, :name, :quantity

  belongs_to :category

  default_scope order("name ASC")
end
