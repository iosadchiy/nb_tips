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
