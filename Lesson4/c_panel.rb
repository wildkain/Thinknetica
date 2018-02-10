
require_relative "lib/station.rb"
require_relative "lib/train.rb"
require_relative "lib/route.rb"


require_relative "lib/passenger_train.rb"
require_relative "lib/cargo_train.rb"
require_relative "lib/passenger_wagon.rb"
require_relative "lib/cargo_wagon.rb"


class ControlPanel
	attr_accessor :station, :trains, :routes

def initialize
	@trains = []
	@stations = []
	@routes = []

def menu
	p "Hello, Boss. What would you want?"
	answer ||= nil
	until answer == "exit" do
		p "Enter SomeThing or input 'exit' "  
		answer  = gets.chomp.to_i
		menu_items(answer)
	end


	#case answer
	#when "me"
	#	puts "#{self.class}"
	#end

end


def menu_items(answer)
	case answer 
	when 1
		p "More boobs!!!"
	when 2
		create_station
	when 3
		create_train
	when 4
	when 5
	when 6
	when 7	
	end
end

def create_station
	p "Enter station name"
	name = gets.chomp.capitalize!
	@station = Station.new(name)
	p "Station #{@station.name} was created"
	@stations <<@station
end
def create_train
	p "Enter Trains number"
	num= gets.chomp.to_i
	p "Enter train's type. '1' - Passenger. '2' - Cargo"
	type = gets.chomp.to_i
	case type 
	when 1
		@train  = PassengerTrain.new(num)
	when 2
		@train = CargoTrain.new(num)
	else
		p "Enter please only 1 or 2."
	end
	p "Train  #{@train.type} #{@train.number} was created"
	@trains << @train
end

def create_route
	# нужны 2 обьекта станции как минимум.
	p "Choose first point of route"
	p "Aviable point based on your creations:"

	@stations. { |st| p "st.name  -" }

	


end
