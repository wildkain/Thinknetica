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
side_a = gets.chomp.to_i

p "Tell me the SECOND parameter - second side"

#takes user's input and save to 'side_b' variable
side_b = gets.chomp.to_i

p "Fine. Tell me the THIRD parameter - third side"
#takes user's input and save to 'side_c' variable
side_c = gets.chomp.to_i
p "Ok, wait a little, please"

# main logic to check triangle. Find hypotenuse(longest side) 
if (side_a>side_b)&&(side_a>side_b)
	cathetus1 = side_b
	cathetus2 = side_c
	hypotenuse = side_a
	elsif (side_b>side_a)&&(side_b>side_c)
		cathetus1 = side_a
		cathetus2 = side_c
		hypotenuse = side_b
	else
		cathetus1 = side_a
		cathetus2 = side_b
		hypotenuse = side_c
		
	end
sleep(2)
#check type of triangle
# First case - check Piphagor's theory
# Second  - try to find equal sides(but not all)
# Third   - try to compare all sides. Find all eaqual case

if (hypotenuse**2) == (cathetus1**2) + (cathetus2**2)
	p "This is right triangle, Pifagor confirmed"

elsif (side_a == side_b)&&(side_b != side_c)||(side_b == side_c)&&(side_a != side_c)||(side_a == side_c)&&(side_b != side_c)
	p "This is isosceles triangle"
elsif (side_a==side_b)&&(side_b==side_c)&&(side_a==side_c)
	p "This is isosceles equilateral triangle. Not a right triangle, sorry("	
else
	p "This is triangle with diff sides(all)."
end	



