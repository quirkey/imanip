module Imanip
  module Interface

    class Magick
      class << self
        @execute_path = ''
        attr_accessor :execute_path
      end

      attr_reader :width, :height, :format, :image_path

      def initialize(path)
        @image_path = path
        identify
      end
      

      alias_method :columns, :width
      alias_method :rows, :height

      # Return the dimensions of the image as an array of Fixnums [width,height]
      def dimensions
        [width,height]
      end
      
      # Returns true if the image is taller then it is long
      def portrait?
        width < height
      end

      # Returns true if the image is longer then it is tall
      def landscape?
        width > height
      end

      # Returns true if width == height
      def square?
        width == height
      end

      # Returns symbol of the images orientation. Can be :landscape, :portrait, or :square
      def orientation
        if landscape?
          :landscape
        elsif portrait?
          :portrait
        else
          :square
        end
      end

      def crop(to_file, options = {})
        @options = options
        parse_size_options!
        @options[:crop] = to_geometry_string(@geometry)
        convert(to_file, options)
      end

      def resize(to_file, options = {})
        @options = options
        parse_size_options!
        @options[:resize] = to_geometry_string(@geometry)
        convert(to_file, @options)
      end

      def crop_resize(to_file, options = {})
        @options = options.dup
        parse_size_options!
        crop_resize_string = ""
        crop_width = @geometry[:width]
        crop_height =  @geometry[:height]
        if !(crop_height.nil? || crop_width.nil?)
          if width == height
            if portrait?
              crop_resize_string << "-resize #{to_geometry_string(:width => crop_width)}"
            else
              crop_resize_string << "-resize #{to_geometry_string(:height => crop_height)}"
            end
          elsif portrait?
            crop_resize_string << "-resize #{to_geometry_string(:width => crop_width)}"
          else
            crop_resize_string << "-resize #{to_geometry_string(:height => crop_height)}"
          end
        else
          crop_resize_string << "-resize #{to_geometry_string(:height => crop_height, :width => crop_width)}"
        end
        gravity = @options.delete(:gravity) || 'North'
        crop_resize_string << " -gravity '#{gravity}'"
        crop_resize_string << " -crop #{to_geometry_string(@geometry)}+0+0"
        crop_resize_string << " #{options_to_string(@options)}"
        convert(to_file,crop_resize_string)
      end
      alias :crop_resized :crop_resize

      def identify(options = {})
        response = execute("#{execute_path}identify #{options_to_string(options)} #{@image_path}")
        matches = response.match(/(JPEG|PNG|GIF)\ (\d+)x(\d+)/)
        raise NotAnImageError, "Could not identify the image #{@image_path} as an image: #{response}" if matches.nil?
        @format = matches[1]
        @width = matches[2].to_i
        @height = matches[3].to_i
      end

      def convert(to_file,options = {})
        command = "#{execute_path}convert #{@image_path} #{options_to_string(options)} #{to_file}"
        response = execute(command)
        # catch errors in response
        possible_errors = [
          /invalid argument/
        ]
        possible_errors.each do |error|
          raise(CouldNotConvertError, response + " when " + command) if response =~ error
        end
        # assert that the new file exits
        File.readable?(to_file) ? Imanip::Image.new(to_file, :magick) : raise(CouldNotConvertError)
      end

      private

      def parse_size_options!
        @geometry = {}
        if @options[:geometry]
          width, height = @options.delete(:geometry).split('x')
          @geometry = {:width => width, :height => height}
        end
        if @options[:dimensions]
          width, height = @options.delete(:dimensions) 
          @geometry = {:width => width, :height => height}
        end
        @geometry = {:width => @options.delete(:width), :height => @options.delete(:height) } if @options[:width] || @options[:height]
        @geometry.collect {|d| d[1].to_i unless d.nil? }
      end

      def to_geometry_string(width_height)
        # puts "width_height: #{width_height.inspect}"
        geometry_string = case width_height
                          when Array
                            width_height.join("x")
                          when Hash
                            "#{width_height[:width]}x#{width_height[:height]}"
                          else
                            width_height.to_s
                          end
       "'#{geometry_string}'"
      end

      def options_to_string(options)
        return options if options.is_a?(String)
        option_string = ""
        options.each do |name,value|
          option_string << "-#{name} #{value} "
        end
        option_string
      end

      def execute(command)
        `#{command} 2>&1`
      end

      def execute_path
        self.class.execute_path
      end
    end

  end
end