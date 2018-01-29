#Заполнить хеш гласными буквами, где значением будет являтся порядковый номер буквы в алфавите (a - 1).
#make alph array
alphabet = ('a'..'z').to_a
letters={}
#for each element in alphabet array
alphabet.each_with_index{ |value, index| letters[value] = index+1 if %w( a e i o u y).include? value}
puts letters
