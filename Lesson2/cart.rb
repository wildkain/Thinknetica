=begin
 Сумма покупок. Пользователь вводит поочередно название товара, цену за единицу и кол-во купленного товара (может быть нецелым числом). Пользователь может ввести произвольное кол-во товаров до тех пор, пока не введет "стоп" в качестве названия товара. На основе введенных данных требуетеся:
Заполнить и вывести на экран хеш, ключами которого являются названия товаров, а значением - вложенный хеш, содержащий цену за единицу товара и кол-во купленного товара. Также вывести итоговую сумму за каждый товар.
Вычислить и вывести на экран итоговую сумму всех покупок в "корзине".
=end


cart = {}
summ = 0

loop do
  print "Input item(or stop): "
  item = gets.chomp
  break if item == "stop"
  print "Input cost: "
  cost = gets.to_f
  print "Input amount: "
  amount = gets.to_f
  cart[item] = {cost: cost, amount: amount, item_summ: cost * amount}
end

puts "So, let see what is on your cart:"
cart.each {|item_name, properties|
puts "#{item_name}, cost per unit: #{properties[:cost]}, sub_total: #{properties[:item_summ]}"
summ+=properties[:item_summ]
}

puts "Fine, total summ of all goods is: $#{summ} "
