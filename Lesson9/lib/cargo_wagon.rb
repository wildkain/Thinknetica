class CargoWagon < Wagon
  MAX_LOAD = 1000

  attr_accessor :space, :loaded_space

  def initialize(number, space)
    super(number, 'Cargo')
    @space = [space, MAX_LOAD].min
    @loaded_space = 0
  end

  def load_space(val)
    return if val > free_space
    @loaded_space += val
  end

  def unload_space(val)
    return if val > @loaded_space
    @loaded_space -= val
  end

  def free_space
    @space - @loaded_space
  end

  def show(wagon)
    p "Number: #{wagon.number}, Model: #{wagon.model}, Free space: #{wagon.free_space}, Loaded: #{wagon.loaded_space}"
  end
end
