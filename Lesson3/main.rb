require_relative "station.rb"
require_relative "train.rb"
require_relative "route.rb"

one = Train.new(91, 'passenger',  '15')
two = Train.new(16,  'cargo',  '21')
station  = Station.new("Valuiki")
station2 = Station.new("Voronezh")
station3 = Station.new("Povorino")
moscow = Station.new("Moscow")
piter = Station.new("Piter")
london = Station.new("London")

route1 = Route.new(station, station2)
route2 = Route.new(moscow, piter)
route1.add_to_list(station3)
route2.add_to_list(london)
#route1.print_list
#route1.delete_medium("grabli")
#route1.print_list

#p "--------------------------------------"

one.setup_route(route1)


#one.route.print_list

#p "--------------------------------------"

two.setup_route(route2)
#two.route.print_list
#p "--------------------------------------"
#p one.current_station

#one.last_station
p "--------------------------------------"

p "Cейчас  - - #{two.current_station.name}"
p "Отправляем на следующую станцию"
two.move_forward
p "Прибыли, теперь мы в  - -#{two.current_station.name}"
p "В #{two.current_station.name} теперь поездов: #{two.current_station.trains.count}"
sleep(1)

p two.current_station
two.move_forward
p two.current_station
two.move_backward
p two.current_station
two.move_backward
two.move_backward
two.move_backward
two.move_backward
two.move_forward

p "_______________________"

p two.current_station
#p two.route.stations.each {|st| p st.name}



p two.current_speed
#p two.wagons
p two.speed_up(80)
p two.speed_up(80)
p two.speed_up(80)
p two.speed_up(80)
p two.speed_up(80)
p two.current_speed
#p two.change_speed(-40)
#p two.current_speed
#two.add_wagons(5)
#p two.wagons
