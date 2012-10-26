ActiveAdmin.register Stuff do
  form do |f|
    f.inputs "Details" do
      f.input :name
      f.input :quantity
      f.input :category, :include_blank => false
    end

    f.buttons
  end

  index do
    column :name
    column :quantity
    column :category
    default_actions
  end

  filter :name
  filter :category
end
