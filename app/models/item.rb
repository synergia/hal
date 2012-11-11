class Item < ActiveRecord::Base
  STATES = %w(available ordered taken used)

  attr_accessible :category_id, :code, :comment, :name, :state, :user_id, :project_id

  validates_presence_of :category_id, :code, :name, :state
  validates_uniqueness_of :code

  validate do
    if state == "taken" && user_id.blank?
      errors.add(:user, "can't be blank if state = taken")
    end

    if state == "used" && project_id.blank?
      errors.add(:project, "can't be blank if state = used")
    end
  end

  belongs_to :category
  belongs_to :user
  belongs_to :project

  default_scope order("name ASC")

  STATES.each do |st|
    scope st, where(:state => st)
    define_method "#{st}?" do
      self.state == st
    end
  end
end
