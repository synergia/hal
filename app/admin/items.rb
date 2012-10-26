ActiveAdmin.register Item do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :code
      f.input :category, :include_blank => false
      f.input :user
      f.input :state, :as => :select, :collection => Item::STATES, :include_blank => false
      f.input :project
      f.input :comment
    end

    f.buttons
  end

  index do
    column :code
    column :name
    column :category
    column :state do |item|
      case item.state
      when "taken"
        "Taken by %s" % (link_to item.user.name, user_path(item.user))
      when "used"
        "Used in %s" % (link_to item.project.name, project_path(item.project))
      when "ordered"
        "Ordered by %s" % (link_to item.user.name, user_path(item.user))
      else
        item.state.capitalize
      end.html_safe
    end

    column "Actions" do |item|
      links = []
      if current_user.admin?
        links << link_to("Edit", edit_item_path(item), :class => "member_link")
        links << link_to("Delete", item_path(item), :class => "member_link", :method => :delete)
      end
      links << link_to("Order", new_order_path(:order => {:item_id => item.id}), :class => "member_link") if item.available?
      links.join(" ").html_safe
    end
  end

  scope :all
  scope :available
  scope :ordered
  scope :taken
  scope :used

  filter :code
  filter :name
  filter :category
  filter :user
  filter :project
  filter :state, :as => :select, :collection => Item::STATES

  config.clear_action_items!

  action_item do
    if current_user.admin?
      link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_name), new_resource_path)
    end
  end
end
