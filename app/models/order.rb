class Order < ActiveRecord::Base
  STATES = %w(pending accepted rejected)
  attr_accessible :comment, :item_id, :project_id
  attr_accessor :accepting

  belongs_to :item
  belongs_to :user
  belongs_to :project

  before_create :set_default_state

  validates_presence_of :item

  validate do
    if !accepting && item && !item.available?
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
    self.accepting = true
    self.status = "accepted"
    Order.transaction do
      item.state = "ordered"
      item.user = self.user
      item.project = self.project
      item.save!
      self.save!
    end

    send_email
  end

  def reject!
    self.accepting = true
    self.status = "rejected"
    save!

    send_email
  end

  def name
    "##{id} (#{item.name})"
  end

  def send_email
    MainMailer.order_status(self).deliver
  end


  protected

  def set_default_state
    self.status = "pending"
  end
end
