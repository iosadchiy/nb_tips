NB Tips
=======


Guess file's mime type from extension
-------------------------------------

```ruby
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

```ruby
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

Notifier.some_kind_of_notification(user).deliver
```

Also consider using [broadcast](https://github.com/futuresimple/broadcast)


Ping TLDs
---------

```bash
for host in uz tm pn io ac cm pw ai mn bi; do ping -qc5 $host; done
```


Bash: Find and replace in files
-------------------------------

(yeah, I want my own version of this)

```bash
find -type f | xargs sed -i 's/find this string/and replace to this/g'
```

Canvas: convert image to grayscale
----------------------------------

```javascript
(function() {
    var supportsCanvas = !!document.createElement('canvas').getContext;
    supportsCanvas && (window.onload = greyImages);

    function greyImages() {
        var ctx = document.getElementsByTagName("canvas")[0].getContext('2d'),
            img = document.getElementById("cvs-src"),
            imageData, px, length, i = 0,
            grey;

        ctx.drawImage(img, 0, 0);

        // Set 500,500 to the width and height of your image.
        imageData = ctx.getImageData(0, 0, 500, 500);
        px = imageData.data;
        length = px.length;

        for ( ; i < length; i+= 4 ) {
            grey = px[i] * .3 + px[i+1] * .59 + px[i+2] * .11;
            px[i] = px[i+1] = px[i+2] = grey;
        }

        ctx.putImageData(imageData, 0, 0);
    }
})();
```

Rake gotcha: environment changed without notice
-----------------------------------------------

```bash
rake db:schema:load db:test:clone_structure db:seed_fu
```

Seeds will make their way to the test database as
db:test:clone_structure task changes `Rails.env` to 'test'


Rspec matcher for accepts_nested_attributes_for
-----------------------------------------------

```ruby
# in model
  accepts_nested_attributes_for :images

# in specs
  it { should accept_nested_attributes_for :images }

# spec/support/accept_nested_attributes_matcher.rb
RSpec::Matchers.define :accept_nested_attributes_for do |association_name|
  match do |object|
    object.class.instance_methods.include? "#{association_name}_attributes="
  end
end

```


Close Empathy chat windows with Esc
-----------------------------------

/usr/share/empathy/empathy-chat-window.ui

`<accelerator key="W" modifiers="GDK_CONTROL_MASK"/>`
change to
`<accelerator key="Escape" />`


## Ubuntu software center - remove ads ##

/usr/share/software-center/softwarecenter/ui/gtk3/views/catview_gtk.py

comment out `self._append_banner_ads()`


Customize Xubuntu fresh installation
------------------------------------

How to understand that Linux is evil?

1. Use Ubuntu
2. Try other Linux dists
3. Buy a Mac

Seems like I'm at stage 2. now.

Anyway let's try to make it work for us. Keep in mind: 

* introduce as little customizations as possible
* do try to understand the way this dist is supposed to be used

Customizations:

1. Keyboard: use Capslock as additional Control, use Capslock LED as layout indicator:
    Settings Manager -> Session and Startup -> add new item
    `setxkbmap -option ctrl:nocaps,grp_led:caps`
    While you're here uncheck Blueman Applet to save precious 30mb out of our 1gb memory

2. Thunderbird:
    Account Settings -> Synchronization & Storage -> Advanced -> uncheck some folders, sync only recent 30 days
                        Local Folders -> Disk space -> remove messages older than 30 days

3. Firefox:
    Install LastPass

4. Hibernate:
    As suspend [is not going to work until 3.5 kernel](https://bugs.launchpad.net/ubuntu/+source/hibernate/+bug/992229/comments/2) (12.10 release) use hibernation instead
    Enable hibernation: [http://askubuntu.com/questions/94754/how-to-enable-hibernation-in-12-04]
    Settings Manager -> Power -> use hibernation where possible
