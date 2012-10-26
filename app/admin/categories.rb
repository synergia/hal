ActiveAdmin.register Category do
  index do
    column :name
    column "Actions" do |category|
      links = []
      links << link_to("View", items_path(:q => {:category_id_eq => category.id}), :class => "member_link")
      if current_user.admin?
        links << link_to("Edit", edit_category_path(category), :class => "member_link")
        links << link_to("Delete", category_path(category), :class => "member_link", :method => :delete)
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
