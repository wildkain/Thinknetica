=begin
Сделать хеш, содеращий месяцы и количество дней в месяце.
В цикле выводить те месяцы, у которых количество дней ровно 30
=end
months = {janyary: 31, febrary: 28, march: 31, april: 30, may: 31, june: 30, july: 31, august: 31, september: 30, october: 31, november: 30, december: 31}

months.each {|month, days| puts "#{month}: #{days}" if days.eql?(30)}
