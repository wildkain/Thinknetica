=begin
Квадратное уравнение. Пользователь вводит 3 коэффициента a, b и с. 
Программа вычисляет дискриминант (D) и корни уравнения (x1 и x2, если они есть) и выводит значения 
дискриминанта и корней на экран. При этом возможны следующие варианты:
  Если D > 0, то выводим дискриминант и 2 корня
  Если D = 0, то выводим дискриминант и 1 корень (т.к. корни в этом случае равны)
  Если D < 0, то выводим дискриминант и сообщение "Корней нет"
Подсказка: Алгоритм решения с блок-схемой (www.bolshoyvopros.ru). 
Для вычисления квадратного корня, нужно использовать  	
Math.sqrt
 
 Например,  
 
Math.sqrt(16)
 
  вернет 4, т.е. квадратный корень из 16.
	
=end

programm_name = 'Sqrt'
p "Hello, my name is #{programm_name}. I help you to find your roots."
p "Need only 3 coefficients for this. So tell me FIRST coefficient"

# first coeff.
a = gets.chomp.to_f

p "Second..."
b = gets.chomp.to_f

p "And THIRD"
c = gets.chomp.to_f

# Calculate discriminant
d = b**2 - (4 * a * c)

# if discriminant is greater than 0  - two roots, if d < 0 - no roots. If d=0 - one root.
if d > 0
	sqrt = Math.sqrt(d) 
	x1 = ( ( -b + sqrt ) / 2 * a).round(3)
  	x2 = ( ( b + sqrt ) / 2 * a).round(3)
	puts "Discriminant = #{d}. Root x1 = #{x1}. Root x2 = #{x2}"
elsif d = 0
   	x = (-b / 2 * a)
	puts "Discriminant = #{d}. Root x = #{x}"
else 
	puts "Discriminant = #{d}. Корней нет"
end
