class Wagon
	attr_accessor :number
	include Manufacturer
  include Validator

  def initialize(number)
    @number = number[:name]
    validate!(number)
  end


end
