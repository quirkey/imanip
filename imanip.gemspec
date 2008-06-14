(in /Users/aaronquint/Sites/imanip)
Gem::Specification.new do |s|
  s.name = %q{imanip}
  s.version = "0.1.0"

  s.specification_version = 2 if s.respond_to? :specification_version=

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Aaron Quint"]
  s.date = %q{2008-06-14}
  s.description = %q{Super-quick image resizing using the ImageMagick command line tools}
  s.email = ["aaron@quirkey.com"]
  s.extra_rdoc_files = ["History.txt", "License.txt", "Manifest.txt", "README.txt"]
  s.files = ["History.txt", "License.txt", "Manifest.txt", "README.txt", "Rakefile", "config/hoe.rb", "config/requirements.rb", "init.rb", "install.rb", "lib/imanip.rb", "lib/imanip/errors.rb", "lib/imanip/image.rb", "lib/imanip/imanip_magick.rb", "lib/imanip/version.rb", "test/landscape_test.jpg", "test/portrait_test.jpg", "test/test_helper.rb", "test/test_imanip_magick.rb", "uninstall.rb"]
  s.has_rdoc = true
  s.homepage = %q{http://quirkey.rubyforge.org}
  s.post_install_message = %q{}
  s.rdoc_options = ["--main", "README.txt"]
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{quirkey}
  s.rubygems_version = %q{1.1.1}
  s.summary = %q{Super-quick image resizing using the ImageMagick command line tools}
  s.test_files = ["test/test_helper.rb", "test/test_imanip_magick.rb"]
end
