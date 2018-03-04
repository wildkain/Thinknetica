class CargoWagon < Wagon
  MAX_LOAD  = 1000
  attr_accessor :space, :loaded_space

  def initialize(number, space)
    super(number)
    @space = [space, MAX_LOAD].min
    @loaded_space = 0
    @model = "Cargo"
  end

  def load_space(val)
    return if val > (@space - @loaded_space)
    @loaded_space += val
  end

  def unload_space(val)
    return if val > @loaded_space
    @loaded_space -= val
  end

  def free_space
    free_space = @space - @loaded_space
  end
end
