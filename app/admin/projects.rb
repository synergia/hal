ActiveAdmin.register Project do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :state, :as => :select, :collection => Project::STATES
      f.input :users
    end

    f.buttons
  end

  index do
    column :id
    column :name
    column :state
    column :users do |project|
      project.users.map do |user|
        link_to user.name, a_user_path(user)
      end.join(", ").html_safe
    end
    column :items do |project|
      project.items.map do |item|
        link_to item.name, a_item_path(item)
      end.join(", ").html_safe
    end

    default_actions
  end
end
