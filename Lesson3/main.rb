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
london = Station.new("london")

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
p "В лондоне теперь поездов: #{london.trains.count}"
sleep(1)
p "Отправляем на следующую станцию"
two.move_forward
p "Прибыли, теперь мы в  - -#{two.current_station.name}"
p "В Лондоне теперь поездов: #{london.trains.count}"
p "В Питере теперь поездов: #{piter.trains.count}"
sleep(1)
p "Забыл выключить утюг"
p "Возвращаемся"
two.move_backward
p "Прибыли, теперь мы в  - -#{two.current_station.name}"

p "В Лондоне теперь поездов: #{london.trains.count}"
p "В Питере теперь поездов: #{piter.trains.count}"
p "--------------------------------------"
