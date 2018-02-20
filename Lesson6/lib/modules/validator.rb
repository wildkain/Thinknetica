module Validator

  def valid?
    validate!(self.number,"String")
  rescue
    false
  end


  protected

  # validate data type and empty?
  def validate!(attrs)
      attrs.each do |attr|
        puts attr
      end
  end
end
