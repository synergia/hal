class Stuff < ActiveRecord::Base
  attr_accessible :category_id, :name, :quantity

  belongs_to :category
end
