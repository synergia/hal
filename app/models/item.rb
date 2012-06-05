class Item < ActiveRecord::Base
  STATES = [:operative, :crippled]

  attr_accessible :category_id, :code, :comment, :name, :state, :user_id

  validates_presence_of :category_id, :code, :name, :state

  belongs_to :category
  belongs_to :user
end
