class CargoTrain < Train
  attr_reader :type
# child class of Train




	def initialize(number)
		super
		@type = "CargoTrain"
	end


	def move_forward
		super
	end


	def move_backward
	super
	end

	def setup_route(route)
		super
		route.stations.first.trains << self
	end


	def add_wagons(wagon)
		return if !cargo_wagon?(wagon)
		super
	end


private

  def cargo_wagon?(wagon)
    wagon.instance_of? CargoWagon
  end

end
