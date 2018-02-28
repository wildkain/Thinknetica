class Wagon
	attr_accessor :number
	include Manufacturer
  include Validator

  def initialize(number)
    validate_presence(number)
    @number = number
  end


def valid?
  validate_presence(@number)
  true
end

end
