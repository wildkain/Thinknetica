class Wagon
  include Manufacturer
  include Validation
  extend Accessors

  attr_accessors_with_history :number
  attr_accessor :model

  validate :number, :presence

  def initialize(number, model)
    @number = number
    @model = model
    validate!
    end
end
