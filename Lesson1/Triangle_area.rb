# Short programm for calculate area of triangle

programm_name = 'Triangle Area'
p "Hello, my name is #{programm_name}. I help you to find area of tringle."
p "Need only 2 parameters for this. So tell me BASE of triangle in santimetres"

#take user's input and save to 'base' variable
base = gets.chomp.to_i

p "Fine. Tell me the second parameter - HEIGHT"

#takes user's input and save to 'height' variable
height = gets.chomp.to_i

# calculate area and save to variable
area = 0.5*base*height

p "Ok, wait a little, please"
sleep(3)
p "Well done! Area of triangle is equal to #{area} !"

