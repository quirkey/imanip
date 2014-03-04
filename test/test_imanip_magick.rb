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

  def test_ratio_should_return_width_over_height
    assert_equal(@landscape_image.width.to_f / @landscape_image.height.to_f, @landscape_image.ratio)
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

    dimensions = [200,153]
    assert @landscape_image.crop_resize(new_image_path, :dimensions => dimensions)
    @new_image = new_imanip_image(new_image_path)
    assert_equal dimensions, @new_image.dimensions

    dimensions = [100,125]
    assert @portrait_image.crop_resize(new_image_path, :dimensions => dimensions)
    @new_image = new_imanip_image(new_image_path)
    assert_equal dimensions, @new_image.dimensions

    dimensions = [100,125]
    assert @landscape_image.crop_resize(new_image_path, :dimensions => dimensions)
    @new_image = new_imanip_image(new_image_path)
    assert_equal dimensions, @new_image.dimensions
  end

  def test_scale_resize_should_scale_and_resize_image_to_scaled_dimensions
    dimensions = [400,315]
    scaled = [600,315]
    assert @landscape_image.scale_resize(new_image_path, :dimensions => dimensions, :scale => scaled)
    @new_image = new_imanip_image(new_image_path)
    assert_equal scaled, @new_image.dimensions

    dimensions = [411,519]
    scaled = [411,600]
    assert @portrait_image.scale_resize(new_image_path, :dimensions => dimensions, :scale => scaled)
    @new_image = new_imanip_image(new_image_path)
    assert_equal scaled, @new_image.dimensions
  end

  def test_crop_resize_should_crop_and_resize_image_to_exact_dimensions_with_square_dimensions
    dimensions = [100,100]
    assert @landscape_image.crop_resize(new_image_path, :dimensions => dimensions)
    @new_image = new_imanip_image(new_image_path)
    assert_equal dimensions, @new_image.dimensions
  end

  def test_crop_resize_should_return_a_imanip_image
    dimensions = [100,100]
    @new_image = @landscape_image.crop_resize(new_image_path, :dimensions => dimensions)
    assert @new_image.is_a?(Imanip::Image)
    assert_equal dimensions, @new_image.dimensions
  end

  def test_should_throw_errors_if_image_could_not_be_converted
    assert_raise(Imanip::CouldNotConvertError) do
       @portrait_image.resize(new_image_path, :v => "bad option")
    end
  end

  def test_should_be_shell_safe
    dimensions = [100, 100]
    # exception should be thrown when identifying image
    # since ; is in path trying to run a second command
    assert_raises(Imanip::NotAnImageError) do
      image = Imanip::Image.new("#{landscape_image_path};blah")
    end
  end

  def new_imanip_image(path,interface = :magick)
    Imanip::Image.new(path,interface)
  end
end