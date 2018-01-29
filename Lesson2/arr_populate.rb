=begin
Заполнить массив числами от 10 до 100 с шагом 5
=end
#range to array with step.
arr = (10..100).step(5).to_a

#populate with loop
arr2 = []
num = 5
while num < 100
  num += 5
  arr2 << num
end

puts arr || arr2

