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
