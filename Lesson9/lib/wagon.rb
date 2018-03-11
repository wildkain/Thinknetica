class Wagon
  include Manufacturer
  include Validation
  include Accessors

  attr_accessor :number, :model

  validate :number, :presence

  def initialize(number, model)
    @number = number
    @model = model
    validate!
    end
end
