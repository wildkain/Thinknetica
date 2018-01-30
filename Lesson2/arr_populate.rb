=begin
Заполнить массив числами от 10 до 100 с шагом 5
=end
#range to array with step.
arr = (10..100).step(5).to_a

#populate with loop

start, limit, step = 10, 100, 5
arr2 = []
num = start - step

while num  < 100
  num  += step
  arr2 << num
end


puts arr || arr2

