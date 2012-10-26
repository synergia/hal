ActiveAdmin.register Project do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :state, :as => :select, :collection => Project::STATES
      f.input :users, :as => :check_boxes
    end

    f.buttons
  end

  index do
    column :id
    column :name
    column :state
    column :users do |project|
      project.users.map do |user|
        link_to user.name, user_path(user)
      end.join(", ").html_safe
    end
    column :items do |project|
      project.items.map do |item|
        link_to item.name, item_path(item)
      end.join(", ").html_safe
    end

    column "Actions" do |project|
      links = []
      links << link_to("View", project_path(project), :class => "member_link")
      if current_user.admin?
        links << link_to("Edit", edit_project_path(project), :class => "member_link")
        links << link_to("Delete", project_path(project), :class => "member_link", :method => :delete)
      end
      links.join(" ").html_safe
    end
  end

  config.clear_action_items!

  action_item do
    if current_user.admin?
      link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_name), new_resource_path)
    end
  end

end
