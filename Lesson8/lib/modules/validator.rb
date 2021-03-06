module Validator
  def valid?
    validate!
    true
  rescue StandardError
    false
  end

  # validate data type and empty?
  def validate_presence(atr)
    raise 'Empty Attribute' if atr.nil?
  end

  def validate_length(atr)
    raise NameError, 'Attribute is too short' if atr.size < 3
  end
end
