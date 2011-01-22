# encoding: UTF-8
require File.expand_path('../lib/imanip/version', __FILE__)

Gem::Specification.new do |s|
  s.name        = "imanip"
  s.summary     = "Super-quick image resizing using the ImageMagick command line tools"
  s.description = "Super-quick image resizing using the ImageMagick command line tools"
  s.email       = "aaron@quirkey.com"
  s.homepage    = "http://quirkey.rubyforge.org"
  s.authors     = ["Aaron Quint"]
  s.version     = Imanip::Version

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]
end
