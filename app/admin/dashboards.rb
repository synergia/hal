ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.

  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  section "Pending orders", :if => proc { current_user.admin? } do
    table do
      tr do
        th "Item"
        th "Project"
        th "User"
        th "Date"
      end
      Order.pending.recent(5).map do |order|
        tr do
          td link_to(order.item.name, order_path(order))
          td (order.project ? link_to(order.project.name, order_path(order)) : "N/A")
          td link_to(order.user.name, order_path(order))
          td order.created_at.to_s(:short)
        end
      end
    end
  end

  section "Your orders" do
    table do
      tr do
        th "Item"
        th "Status"
        th "Date"
      end
      current_user.orders.order("created_at DESC").map do |order|
        tr do
          td link_to(order.item.name, order_path(order))
          td order.status
          td order.created_at.to_s(:short)
        end
      end
    end
  end

  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end

  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

  # == Conditionally Display
  # Provide a method name or Proc object to conditionally render a section at run time.
  #
  # section "Membership Summary", :if => :memberships_enabled?
  # section "Membership Summary", :if => Proc.new { current_admin_user.account.memberships.any? }

end
