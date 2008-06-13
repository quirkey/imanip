module Imanip
  module Errors
    class NotAnImageError < RuntimeError; end;
    class CouldNotConvertError < RuntimeError; end;
  end
end