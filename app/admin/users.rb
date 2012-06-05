ActiveAdmin.register User do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end

    f.buttons
  end

  index do
    column :name
    column :email
    column :created_at
    column :updated_at

    default_actions
  end
end
