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

  index do
    column :id
    column :name
    column :email
    column :role
    column :projects do |user|
      user.projects.map do |project|
        link_to project.name, a_project_path(project)
      end.join(", ").html_safe
    end

    default_actions
  end
end
