require 'test/unit'
require File.expand_path(File.join(File.dirname(__FILE__), '../lib/imanip'))

class Test::Unit::TestCase
  
  protected
  def current_path
    File.expand_path(File.dirname(__FILE__))
  end
  
  def portrait_image_path
    File.join(current_path,'portrait_test.jpg')
  end
  
  def landscape_image_path
    File.join(current_path,'landscape_test.jpg')
  end
  
  def new_image_path
    File.join(current_path, "new_file.jpg")
  end
  
end