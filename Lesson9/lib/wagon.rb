class Wagon
  include Manufacturer
  include Validation
  extend Accessors

  strong_attr_accessor :number, Fixnum
  attr_accessor :model

  validate :number, :presence
  validate :number, :type, Fixnum

  def initialize(number, model)
    @number = number
    @model = model
    validate!
    end
end
