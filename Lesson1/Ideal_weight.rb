# This little program will help you know your ideal weight (but it's not totally true)
# Let's start


programm_name = "'Ideal weight'"


p "Hi, i am a smarty programm, call me #{programm_name}"
p "I can help you find out your ideal weight"
p "Let's get acquainted! What is your name?"

#take user input and save to variable
name = gets.chomp

p "Fine, #{name}. Now, I need to know your height in centimeters"

#take user's input and save to variable, convert to int
height = gets.chomp.to_i 

p "Exelent! So,  I need a little time to calculate ..."

# Take 'height' parameter and calculate "ideal_weight" as 'height -110'
ideal_weight = height - 110
sleep(2)

#Inform user about they are ideal weight
p "Congrats! Your ideal weight is equal to #{ideal_weight}kg! Good bye"


