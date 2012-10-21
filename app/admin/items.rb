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
    column :project
    column :state
    column :user
    column :created_at
    column :updated_at

    default_actions
  end

  scope :all
  scope :available

  filter :code
  filter :name
  filter :category
  filter :user
  filter :project
  filter :state, :as => :select, :collection => Item::STATES
end
