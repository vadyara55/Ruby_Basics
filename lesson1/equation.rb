puts "Дано уравнение : ax^2+bx+c=0"
puts "Введите коэфициенты a ,b ,c "
a = gets.to_f
b = gets.to_f
c = gets.to_f
d = b**2 - 4.0 * a * c
if d < 0
  puts "Действительных корней нет"
elsif d > 0
  sqrt = Math.sqrt(d)
  x1 = -b + sqrt / (2.0 * a)
  x2 = -b - sqrt / (2.0 * a)
  puts "Первый корень = #{x1}, второй = #{x2}"
else
x3 = -b / (2.0 * a)
puts "Корень уравнения = #{x3}"
end
