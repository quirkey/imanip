module Quirkey
  module Imanip
    class Image
      
      def initialize(path,interface = :magick)
        @image_path = path
        load_interface(interface)
      end
      
      private
      def load_interface(interface)
        @interface = Quirkey::Imanip::Interface.const_get("#{interface.to_s.capitalize}").new(@image_path)
      end
      
      def method_missing(method, *args)
        @interface.send(method,*args)
      end
      
      
    end
    
    module Errors
      class NotAnImageError < RuntimeError; end;
      class CouldNotConvertError < RuntimeError; end;
    end
  end
end