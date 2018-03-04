class Wagon
  include Manufacturer
  include Validator

	attr_accessor :number, :model

  def initialize(number)
    @number = number
    validate!
    @model = self.is_a?(PassengerWagon) ? @model  = "Passenger" : @model = "Cargo"
  end

  protected

  def validate!
    validate_presence(@number)
  end
end
