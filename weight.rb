puts "введите ваше имя"
name = gets.to_s
puts "Введите ваш рост"
growth = gets.to_i
ideal_weight = growth - 110
if ideal_weight < 0
  puts "Ваш вес оптимальный"
else
  puts "#{name},ваш идеальный вес - #{ideal_weight}"
end
