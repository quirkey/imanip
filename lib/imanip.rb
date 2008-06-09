%w{image imanip_magick}.each do |lib|
  require File.expand_path(File.dirname(__FILE__)) + "/imanip/#{lib}"
end