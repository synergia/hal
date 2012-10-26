ActiveAdmin.register User do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :role, :as => :select, :collection => User::ROLES, :include_blank => false
      f.input :function, :as => :select, :collection => User::FUNCTIONS, :include_blank => false
      f.input :projects
      # f.input :password
      # f.input :password_confirmation
    end

    f.buttons
  end

  show do |ad|
    attributes_table do
      row :id
      row :name
      row :email
      row :phone
      row :function
      row :role
      row :projects do |user|
        user.projects.map do |project|
          link_to project.name, project_path(project)
        end.join(", ").html_safe
      end
      row :items do |user|
        user.items.map do |item|
          link_to item.name, item_path(item)
        end.join(", ").html_safe
      end
      row :orders do |user|
        user.orders.map do |order|
          link_to order.name, order_path(order)
        end.join(", ").html_safe
      end
      row :sign_in_count
      row :current_sign_in_at
      row :last_sign_in_at
      row :current_sign_in_ip
      row :last_sign_in_ip
    end
    active_admin_comments
  end

  index do
    column :id
    column :name
    column :email
    column :role
    column :projects do |user|
      user.projects.map do |project|
        link_to project.name, project_path(project)
      end.join(", ").html_safe
    end

    column "Actions" do |user|
      links = []
      links << link_to("View", user_path(user), :class => "member_link")
      if current_user.admin?
        links << link_to("Edit", edit_user_path(user), :class => "member_link")
        links << link_to("Delete", user_path(user), :class => "member_link", :method => :delete)
      end
      links.join("&nbsp").html_safe
    end
  end

  filter :email
  filter :name
  filter :role

  config.clear_action_items!

  action_item do
    if current_user.admin?
      link_to(I18n.t('active_admin.new_model', :model => active_admin_config.resource_name), new_resource_path)
    end
  end
end
