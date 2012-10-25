class Item < ActiveRecord::Base
  STATES = %w(available ordered taken used)

  attr_accessible :category_id, :code, :comment, :name, :state, :user_id, :project_id

  validates_presence_of :category_id, :code, :name, :state
  validates_uniqueness_of :code

  belongs_to :category
  belongs_to :user
  belongs_to :project

  STATES.each do |st|
    scope st, where(:state => st)
    define_method "#{st}?" do
      self.state == st
    end
  end
end
