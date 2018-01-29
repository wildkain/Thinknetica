# Заданы три числа, которые обозначают число, месяц, год (запрашиваем у пользователя).
# Найти порядковый номер даты, начиная отсчет с начала года. Учесть, что год может быть високосным
puts "Hi, input some values, please"
print "Date(numeric): "
day = gets.to_i
print "Month(numeric): "
month = gets.to_i
print "Year(numeric): "
year = gets.to_i

days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]

if  year % 400 == 0 || (year % 4 == 0 && year % 100 != 0)
  days_in_month[1]=29
end

num_of_days = days_in_month.take(month-1)

days = 0
num_of_days.each {|v| days+=v}

days_from_start = days + day

puts "Days from start of year: #{days_from_start}"
