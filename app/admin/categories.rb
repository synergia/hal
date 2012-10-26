ActiveAdmin.register Category do
  index do
    column :name
    column "Actions" do |category|
      links = []
      links << link_to("View", items_path(:q => {:category_id_eq => category.id}), :class => "member_link")
      links << link_to("Edit", edit_category_path(category), :class => "member_link")
      links << link_to("Delete", category_path(category), :class => "member_link", :method => :delete)
      links.join(" ").html_safe
    end
  end
end
