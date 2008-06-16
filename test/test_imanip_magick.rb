# require File.expand_path(File.join(File.dirname(__FILE__), 'test_helper'))

class ImanipMagickTest < Test::Unit::TestCase

  def setup
    @portrait_image = new_imanip_image(portrait_image_path)
    @landscape_image  = new_imanip_image(landscape_image_path)
  end
  
  def teardown
    File.unlink(new_image_path) if File.readable?(new_image_path)
  end

  def test_should_raise_error_if_not_an_image
    assert_raise(Imanip::NotAnImageError) do
      new_imanip_image(__FILE__)
    end
  end
  
  def test_should_return_an_imanip_image
    assert @portrait_image.is_a?(Imanip::Image) 
  end
  
  def test_should_return_dimensions_as_array
    dimensions = @portrait_image.dimensions
    assert dimensions.is_a?(Array)
    assert_equal [411,519], dimensions
    
    dimensions = @landscape_image.dimensions
    assert dimensions.is_a?(Array)
    assert_equal [400,315], dimensions
  end
  
  def test_portrait_should_return_true_for_portrait_image
    assert @portrait_image.portrait?
  end
  
  def test_portrait_should_return_false_for_landscape_image
    assert !@landscape_image.portrait?
  end
  
  def test_landscape_should_return_true_for_landscape_image
    assert @landscape_image.landscape? 
  end
  
  def test_landscape_should_return_false_for_portrait_image
    assert !@portrait_image.landscape?
  end
  
  def test_resize_should_save_to_new_file
    assert !File.readable?(new_image_path)
    assert @portrait_image.resize(new_image_path, :width => 50)
    assert File.readable?(new_image_path)
  end
  
  def test_resize_should_resize_image_to_new_image_at_dimensions
    dimensions = [100,126]
    assert @portrait_image.resize(new_image_path, :dimensions => dimensions)
    @new_image = new_imanip_image(new_image_path)
    assert_equal dimensions, @new_image.dimensions
  end
  
  def test_resize_should_resize_image_to_new_image_at_width
    width = 100
    assert @portrait_image.resize(new_image_path, :width => width)
    @new_image = new_imanip_image(new_image_path)
    assert_equal width, @new_image.width
    assert_not_equal @portrait_image.height, @new_image.height
  end
  
  def test_crop_resize_should_crop_and_resize_image_to_exact_dimensions
    dimensions = [200,153]
    assert @portrait_image.crop_resize(new_image_path, :dimensions => dimensions)
    @new_image = new_imanip_image(new_image_path)
    assert_equal dimensions, @new_image.dimensions
  end
  
  def test_crop_resize_should_crop_and_resize_image_to_exact_dimensions_with_square_dimensions
    dimensions = [100,100]
    assert @landscape_image.crop_resize(new_image_path, :dimensions => dimensions)
    @new_image = new_imanip_image(new_image_path)
    assert_equal dimensions, @new_image.dimensions
  end
  
  
  def test_should_throw_errors_if_image_could_not_be_converted
    assert_raise(Imanip::CouldNotConvertError) do
       @portrait_image.resize(new_image_path, :v => "bad option")
    end
  end
  
  protected
  def new_imanip_image(path,interface = :magick)
    Imanip::Image.new(path,interface)
  end
  
  
end