= imanip

http://quirkey.sourceforge.com/imanip/
http://github.com/quirkey/imanip/

== DESCRIPTION:

Super-quick image resizing using the ImageMagick command line tools

== FEATURES/PROBLEMS:

- Simple API
- 0% Overhead
- Uses the ImageMagick command line tools (convert, identify)

NOTE:
The API is going to be changing a lot as I try to lock down something really useful. As a quick git-er-done type doodad
it works really well, and I'm already using it on some very high volume production sites.

== SYNOPSIS:


First things, first, Tell me where you keep them:
	
	
	# Rails: production|development|etc.rb
	# or somewhere that gets loaded before you initialize
	
	Imanip::Interface::Magick.execute_path = '/path/to/your/bins/' # eg /usr/local/bin/
	

With an image file at /dir/image.jpg
	
	image = Imanip::Image.new('/dir/image.jpg')
	
This will run identify on the image and make sure its convert-able. If it cant read or interpret it it will raise an Imanip::NotAnImageError.

Once you have the image you can check some properties/attributes
	
	image.width #=> 410 (Fixnum)
	image.height #=> 100 (Fixnum)
	image.format #=> JPEG (String)

There are also some helpers to do some rule based cropping.
	
	image.portrait? #=> false
	image.landscape? #=> true
	image.orientation #=> :landscape
	
After that you can resize and whatever
	
	image.resize('outputfile.jpg', :dimensions => [200,100])
	
I like crop_resize better. It crops AND resizes so you get an image of the exact pixel dimensions you desire.
	
	image.crop_resize('/file/to/output.jpg', :width => 50, :height => 50) #=> output file is an exact 50x50 image

You might also want to catch errors, because they will inevitably happen. Possible Errors

	Imanip::Error # the root, the root, the root is on fire
	Imanip::NotAnImageError # Descends from above, thrown during Imanip#Image.new
	Imanip::CouldNotConvertError # Also from above, thrown if theres an issue with #resize or #crop_resize (options, etc.)

More examples coming soon.

== REQUIREMENTS:

You need ImageMagick. Really any version will do, but I am developing with ImageMagick 6.3.3. 

http://www.imagemagick.org/script/download.php
	

== INSTALL:

First, install ImageMagick:
http://www.imagemagick.org/script/download.php

Make sure you get the command line tools:
		
	$ which 'convert'

Imanip works as a gem or a plugin for Rails.
	
As a gem:
	
	$ sudo gem install imanip
	
In Rails/environment.rb
	config.gem 'imanip'

Or you can get the ABSOLUTE latest from github:

	$ sudo gem install quirkey-imanip -s http://gems.github.com

To install as a plugin (you need git):
	
	$ git clone git://github.com/quirkey/imanip.git vendor/plugins/imanip

== LICENSE:

Copyright (c) 2008 Aaron Quint, Quirkey

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.