module Validator



  # validate data type and empty?
  def validate_presence(atr)
      raise RuntimeError, "Empty Attribute" if atr.nil?
  end

  def validate_length(atr)
    raise NameError, "Attribute is too short" if atr.size < 3
  end
  #validate format with regular expr
  def validate_format(atr)
    raise TypeError, "Invalid FORMAT of identifical number(valid example 000-sd)" unless atr =~ Train::VALID_NUMBER

  end
end
