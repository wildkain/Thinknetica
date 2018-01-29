#Заполнить массив числами фибоначчи до 100

fib = [0, 1, 1]

while (i = fib[-1] + fib[-2]) < 100
  fib.push(i)
end

print fib
