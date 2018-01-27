#Pifagor pants programm
=begin
	Прямоугольный треугольник. Программа запрашивает у пользователя 3 стороны треугольника и определяет,
	 является ли треугольник прямоугольным, используя теорему Пифагора (www-formula.ru) 
	 и выводит результат на экран. Также, если треугольник является при этом равнобедренным 
	 (т.е. у него равны любые 2 стороны), то дополнительно выводится информация о том, 
	 что треугольник еще и равнобедренный. Подсказка: чтобы воспользоваться теоремой Пифагора, 
	 нужно сначала найти самую длинную сторону (гипотенуза) и сравнить ее значение в квадрате 
	 с суммой квадратов двух остальных сторон. Если все 3 стороны равны, то треугольник равнобедренный 
	 и равносторонний, но не прямоугольный.

=end


programm_name = 'Piphagor pants'

p "Hello, my name is #{programm_name}. I help you to check your triangle(a triangle with a right angle or not)"
p "Need only 3 parameters for this(3 sides). "
p "So tell me FIRST side of triangle in santimetres"

#takes user's input and save to 'side_a' variable
side_a = gets.chomp.to_f

p "Tell me the SECOND parameter - second side"

#takes user's input and save to 'side_b' variable
side_b = gets.chomp.to_f

p "Fine. Tell me the THIRD parameter - third side"
#takes user's input and save to 'side_c' variable
side_c = gets.chomp.to_f
p "Ok, wait a little, please"

# main logic to check sides of triangle. Find hypotenuse(longest side) 
sides = [side_a, side_b, side_c]
hypotenuse  = sides.max
sides.delete(hypotenuse)
cathetus1 = sides[0]
cathetus2 = sides[1]
sleep(2)
right= false
#check type of triangle
if hypotenuse**2 == cathetus1**2 + cathetus2**2
  p "This is right triangle, Pifagor confirmed"
  right = true
elsif [side_a, side_b, side_c].uniq.length == 1
  p "This is  equilateral triangle."	
else
  p "Not a right triangle, sorry("
end	

if cathetus1 == cathetus2 && right == true
  p "And this is isosceles triangle"
end
