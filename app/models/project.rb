class Project < ActiveRecord::Base
  STATES = [:in_progress, :finished]
  attr_accessible :name, :state, :user_ids

  has_and_belongs_to_many :users
  has_many :items
end
