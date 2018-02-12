require_relative "lib/station.rb"
require_relative "lib/train.rb"
require_relative "lib/route.rb"


require_relative "lib/passenger_train.rb"
require_relative "lib/cargo_train.rb"
require_relative "lib/passenger_wagon.rb"
require_relative "lib/cargo_wagon.rb"
require_relative "c_panel.rb"

station1= Station.new("Valuiki")
station2 = Station.new("Voronezh")
route1 = Route.new(station1, station2)
