class CargoWagon < Wagon
  MAX_LOAD  = 1000
  attr_accessor :space
  attr_reader :type, :free_space, :loaded_space

  def initialize(number, space)
    @number = number
    space <= MAX_LOAD ? @space = space : @space = MAX_LOAD
    @free_space = space
    @loaded_space = 0
    @type = "Cargo"
  end

  def load_space(val)
    return if val > @free_space
    @free_space -= val
    @loaded_space += val
  end

  def unload_space(val)
    return if val > loaded_space
    @free_space += val
    @loaded_space -= val
  end
end
