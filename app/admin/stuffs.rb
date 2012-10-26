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

    column "Actions" do |stuff|
      links = []
      links << link_to("View", stuff_path(stuff), :class => "member_link")
      if current_user.admin?
        links << link_to("Edit", edit_stuff_path(stuff), :class => "member_link")
        links << link_to("Delete", stuff_path(stuff), :class => "member_link", :method => :delete)
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

  filter :name
  filter :category
end
