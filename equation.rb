puts "Дано уравнение : ax^2+bx+c=0"
puts "Введите коэфициенты a ,b ,c "
a = gets.to_f
b = gets.to_f
c = gets.to_f
d = b**2 - 4*a*c
x1 = (-b + Math.sqrt(d)) / (2*a)
x2 = (-b - Math.sqrt(d)) / (2*a)
x3 = -b/2*a
if d < 0
  puts "Действительных корней нет"
elsif d > 0
  puts "Дискриминант = #{d}, первый корень уравнения x1 = #{x1}, второй корень x2 = #{x2}"
else
  puts "Дискриминант = 0, единственный корень x = #{x3}"
end
