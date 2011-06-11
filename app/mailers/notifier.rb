class TwitterDelivery
  require 'twitterie'

  def initialize(values)
  end

  def deliver!(mail)
    Twitterie.post_direct_message mail.to.first, mail.body.decoded
  end
end


class Notifier < ActionMailer::Base
  default :delivery_method => TwitterDelivery

  def some_kind_of_notification(user)
    mail :to => user.nickname
  end
end
