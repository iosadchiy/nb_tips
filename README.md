NB Tips
=======


Guess file's mime type from extension
-------------------------------------

```
# Gemfile
gem 'mimetype-fu', :git => "git://github.com/jeanmartin/mimetype-fu.git", :require => 'mimetype_fu'

# some_controller.rb
send_file path, :type => File.mime_type(path)
```

mimetype-fu gem has kind of misleading documentation on it's google
code homepage.


Twitterie: Twitter API thin wrapper
-----------------------------------

* uses oauth gem

* [lib/twitterie.rb](https://github.com/tepoga/nb_tips/blob/master/lib/twitterie.rb)


Send notifications using Twitter DMs
------------------------------------

* use Twitterie
* use ActionMailer with custom delivery_method

* mailer and delivery method [app/mailers/notifier.rb](https://github.com/tepoga/nb_tips/blob/master/app/mailers/notifier.rb)
* add msg template to app/views/notifier/some_kind_of_notification.haml

```
# app/mailers/notifier.rb

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


# in your controller

Notifier.some_kind_of_notification.deliver
```

Also consider using [broadcast](https://github.com/futuresimple/broadcast)
