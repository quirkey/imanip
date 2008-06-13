module Imanip
  class ImanipError < RuntimeError; end;
  class NotAnImageError < ImanipError; end;
  class CouldNotConvertError < ImanipError; end;
end