class Wagon
  include Manufacturer
  include Validator

	attr_accessor :number, :model

  def initialize(number)
    @number = number
    validate!
  end

  protected

  def validate!
    validate_presence(@number)
  end
end
