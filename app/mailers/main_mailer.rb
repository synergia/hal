class MainMailer < ActionMailer::Base
  default from: "synergia@pwr.wroc.pl"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.mainmailer.order_status.subject
  #
  def order_status(order)
    @order = order
    mail :to => order.user.email,
         :subject => "Order status update"
  end
end
