ActiveAdmin.register User do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :phone
      f.input :role, :as => :select, :collection => User::ROLES
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
      row :role
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

    default_actions
  end
end
