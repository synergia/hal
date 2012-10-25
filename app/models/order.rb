class Order < ActiveRecord::Base
  STATES = %w(pending accepted rejected)
  attr_accessible :comment, :item_id, :project_id

  belongs_to :item
  belongs_to :user
  belongs_to :project

  before_create :set_default_state

  validates_presence_of :item

  validate do
    if item && !item.available?
      errors.add(:item, "is not available")
    end
  end

  STATES.each do |st|
    scope st, where(:status => st)

    define_method "#{st}?" do
      status == st
    end
  end

  scope :recent, lambda {|n| order("created_at DESC").limit(n) }

  def accept!
    self.status = "accepted"
    Order.transaction do
      item.state = "ordered"
      item.user = self.user
      item.project = self.project
      item.save!
      self.save!
    end
  end

  def reject!
    self.status = "rejected"
    save!
  end



  protected

  def set_default_state
    self.status = "pending"
  end
end
