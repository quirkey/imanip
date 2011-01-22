require 'safe_shell'

%w{image imanip_magick errors}.each do |lib|
  require File.expand_path(File.dirname(__FILE__)) + "/imanip/#{lib}"
end