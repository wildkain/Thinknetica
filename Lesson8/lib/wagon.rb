class Wagon
  include Manufacturer
  include Validator

  attr_accessor :number, :model

  def initialize(number, model)
    @number = number
    @model = model
    validate!
  end

  protected

  def validate!
    validate_presence(@number)
  end
end
