ActiveAdmin.register Order do
  menu :if => proc { current_user.admin? }
  scope :all
  scope :pending
  scope :accepted
  scope :rejected

  index do
    column :item
    column :user
    column :project
    column "Status" do |order|
      order.status.capitalize
    end

    column :created_at
    column :updated_at

    column :actions do |order|
      links = []
      links << link_to("View", order_path(order), :class => "member_link")
      links << link_to("Accept", accept_order_path(order), :class => "member_link") unless order.accepted?
      links << link_to("Reject", reject_order_path(order), :class => "member_link") unless order.rejected?
      links.join(" ").html_safe
    end
  end


  form do |f|
    f.inputs "Details" do
      f.input :item
      f.input :project
      f.input :comment
    end

    f.buttons
  end

  member_action :accept do
    order = Order.find(params[:id])
    order.accept!
    redirect_to orders_path, :notice => "Order accepted"
  end

  member_action :reject do
    order = Order.find(params[:id])
    order.reject!
    redirect_to orders_path, :notice => "Order rejected"
  end


  action_item :only => :show do
    links = []
    if current_user.admin?
      links << link_to("Accept", accept_order_path(order), :class => "member_link") unless order.accepted?
      links << link_to("Reject", reject_order_path(order), :class => "member_link") unless order.rejected?
    end
    links.join(" ").html_safe
  end


  controller do
    def create
      @order = current_user.orders.new(params[:order])
      if @order.save
        redirect_to order_path(@order)
      else
        render :new
      end
    end
  end

  filter :item
  filter :user
  filter :project
  filter :status, :as => :select, :collection => Order::STATES
end
