class Item < ActiveRecord::Base
  STATES = [:operative, :crippled]

  attr_accessible :category_id, :code, :comment, :name, :state, :user_id, :project_id

  validates_presence_of :category_id, :code, :name, :state
  validates_uniqueness_of :code

  belongs_to :category
  belongs_to :user
  belongs_to :project

  scope :available, where(:user_id => nil, :project_id => nil)
end
